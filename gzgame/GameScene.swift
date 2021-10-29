//
//  GameScene.swift
//  gzgame
//
//  Created by gzonelee on 2021/10/16.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
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
        
        let player = Player()
        player.position = CGPoint(x: size.width / 2, y: foreground.frame.maxY)
        addChild(player)
    }
}
