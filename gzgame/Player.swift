//
//  Player.swift
//  gzgame
//
//  Created by gzonelee on 2021/10/26.
//

import Foundation
import SpriteKit

enum PlayerAnimationType: String {
    case walk
}

enum PlayerDirectionType {
    case left
    case right
}

class Player: SKSpriteNode {
  // MARK: - PROPERTIES
    private var walkTextures: [SKTexture]?
  
  // MARK: - Init
    init() {
        let texture = SKTexture(imageNamed: "blob-walk_0")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.walkTextures = self.loadTextures(atlas: "blob", prefix: "blob-walk_", startAt: 0, stopAt: 2)
        self.name = "player"
        self.setScale(1.0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.zPosition = Layer.player.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    // MARK: - Methods
    func walk() {
        guard let walkTextures = walkTextures else {
            preconditionFailure("could not find textures!")
        }
        startAnimation(textures: walkTextures, speed: 0.25, name: PlayerAnimationType.walk.rawValue,
                       count: 0, resize: true, restore: true)
    }
    
    func moveToPosition(pos: CGPoint,
                        direction: PlayerDirectionType,
                        speed: TimeInterval) {
        switch direction {
        case .left:
            xScale = -abs(xScale)
        case .right:
            xScale = abs(xScale)
        }
        let moveAction = SKAction.move(to: pos, duration: speed)
        run(moveAction)
    }
    
    func setupConstraints(floor: CGFloat) {
        let range = SKRange(lowerLimit: floor, upperLimit: floor)
        let lockToPosition = SKConstraint.positionY(range)
        constraints = [lockToPosition]
    }
}
