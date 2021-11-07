//
//  GameScene.swift
//  gzgame
//
//  Created by gzonelee on 2021/10/16.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let player = Player()
    let playerSpeed: CGFloat = 2.5
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background_1")
        background.position = CGPoint.zero
        background.anchorPoint = .zero
        background.zPosition = Layer.background.rawValue
        addChild(background)
        
        let foreground = SKSpriteNode(imageNamed: "foreground_1")
        foreground.anchorPoint = .init(x: 0, y: 0.0)
        foreground.position = .zero
        foreground.zPosition = Layer.foreground.rawValue
        addChild(foreground)
        
        player.position = CGPoint(x: size.width / 2, y: foreground.frame.maxY)
        player.setupConstraints(floor: foreground.frame.maxY)
        addChild(player)
        
        player.walk()
        spawnMultipleGloops()
    }
    
    func touchDown(atPoint pos: CGPoint) {
        let distance = abs(pos.x - player.position.x)
        let calculatedSpeed = TimeInterval(distance / playerSpeed) / 255.0
        
        if pos.x < player.position.x {
            player.moveToPosition(pos: pos,
                                  direction: .left,
                                  speed: calculatedSpeed)
        }
        else {
            player.moveToPosition(pos: pos,
                                  direction: .right,
                                  speed: calculatedSpeed)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    func spawnGloop() {
        let collectible = Collectible(collectibleType: .gloop)
        
        let margin = collectible.size.width * 2
        let dropRange = SKRange(lowerLimit: frame.minX + margin, upperLimit: frame.maxX - margin)
        let randomX = CGFloat.random(in: dropRange.lowerLimit...dropRange.upperLimit)
        collectible.position = .init(x: randomX,
                                     y: player.position.y * 2.5)
        addChild(collectible)
        collectible.drop(dropSpeed: TimeInterval(1.0), floorLevel: player.frame.minY)
    }
    
    func spawnMultipleGloops() {
        let wait = SKAction.wait(forDuration: 1.0)
        let spawn = SKAction.run {[unowned self] in
            self.spawnGloop()
        }
        let sequence = SKAction.sequence([wait, spawn])
        let repeatAction = SKAction.repeat(sequence, count: 10)
        run(repeatAction, withKey: "gloop")
    }
}
