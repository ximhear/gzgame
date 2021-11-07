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
    // Player movement
    var movingPlayer = false
    var lastPosition: CGPoint?
    
    var level: Int = 8
    var numberOfDrops: Int = 10
    var dropSpeed: CGFloat = 1
    var minDropSpeed: CGFloat = 0.12
    var maxDropSpeed: CGFloat = 1
    
    
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
        let touchedNode = atPoint(pos)
        if touchedNode.name == "player" {
            movingPlayer = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchMoved(toPoint: t.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
        }
    }
    
    func touchMoved(toPoint pos: CGPoint) {
        if movingPlayer == true {
            let newPos = CGPoint(x: pos.x, y: player.position.y)
            player.position = newPos
            
            let recordedPosition = lastPosition ?? player.position
            if recordedPosition.x > newPos.x {
                player.xScale = -abs(xScale)
            }
            else {
                player.xScale = abs(xScale)
            }
            
            lastPosition = newPos
        }
    }
    
    func touchUp(atPoint pos: CGPoint) {
        movingPlayer = false
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
        
        switch level {
        case 1, 2, 3, 4, 5:
            numberOfDrops = level * 10
        case 6:
            numberOfDrops = 75
        case 7:
            numberOfDrops = 100
        case 8:
            numberOfDrops = 150
        default:
            numberOfDrops = 150
        }
        
        dropSpeed = 1 / (CGFloat(level) + (CGFloat(level) / CGFloat(numberOfDrops)))
        if dropSpeed < minDropSpeed {
            dropSpeed = minDropSpeed
        }
        else if dropSpeed > maxDropSpeed {
            dropSpeed = maxDropSpeed
        }
       
        GZLogFunc(dropSpeed)
        
        let wait = SKAction.wait(forDuration: dropSpeed)
        let spawn = SKAction.run {[unowned self] in
            self.spawnGloop()
        }
        let sequence = SKAction.sequence([wait, spawn])
        let repeatAction = SKAction.repeat(sequence, count: numberOfDrops)
        run(repeatAction, withKey: "gloop")
    }
}
