//
//  Collectible.swift
//  gzgame
//
//  Created by gzonelee on 2021/11/08.
//

import Foundation
import SpriteKit

enum CollectibleType: String {
    case none
    case gloop
}

class Collectible: SKSpriteNode {
    //MARK: - PROPERTIES
    private var collectibleType: CollectibleType = .none
    
    //MARK: - INIT
    init(collectibleType: CollectibleType) {
        var texture: SKTexture!
        self.collectibleType = collectibleType
        switch self.collectibleType {
        case .gloop:
            texture = SKTexture(imageNamed: "gloop")
        case .none:
            break
        }
        
        super.init(texture: texture, color: .clear, size: texture.size())
        self.name = "co_\(collectibleType)"
        self.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        self.zPosition = Layer.collectible.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not been implemented.")
    }
    
    //MARK: - FUNCTIONS
    func drop(dropSpeed: TimeInterval, floorLevel: CGFloat) {
        let pos = CGPoint(x: position.x, y: floorLevel)
        let scaleX = SKAction.scaleX(to: 1.0, duration: 1.0)
        let scaleY = SKAction.scaleY(to: 1.3, duration: 1.0)
        let scale = SKAction.group([scaleX, scaleY])
        let appear = SKAction.fadeAlpha(by: 1.0, duration: 0.25)
        let moveAction = SKAction.move(to: pos, duration: dropSpeed)
        let actionSequence = SKAction.sequence([appear, scale, moveAction])
        
        self.scale(to: .init(width: 0.25, height: 1))
        self.run(actionSequence, withKey: "drop")
        
//        self.scale(to: .init(width: 1.0, height: 1))
//        let aaa = SKAction.scaleX(to: 2.0, duration: 10.0)
//        let bbb = SKAction.scaleY(to: 2.0, duration: 10.0)
//        let ccc = SKAction.group([aaa, bbb])
//        self.run(ccc, withKey: "drop")
    }
}
