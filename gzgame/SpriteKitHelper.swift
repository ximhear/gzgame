//
//  SpriteKitHelper.swift
//  gzgame
//
//  Created by gzonelee on 2021/10/30.
//

import Foundation
import SpriteKit


enum Layer: CGFloat {
    case background
    case foreground
    case player
    case collectible
}

//MARK: - SpriteKit Extensions

extension SKSpriteNode {
    func loadTextures(atlas: String, prefix: String, startAt: Int, stopAt: Int) -> [SKTexture] {
        var textureArray = [SKTexture]()
        let textureAtlas = SKTextureAtlas(named: atlas)
        for i in startAt...stopAt {
            let textureName = "\(prefix)\(i)"
            let temp = textureAtlas.textureNamed(textureName)
            textureArray.append(temp)
        }
        return textureArray
    }
    
    func startAnimation(textures: [SKTexture], speed: Double, name: String, count: Int, resize: Bool, restore: Bool) {
        if action(forKey: name) == nil {
            let animation = SKAction.animate(with: textures, timePerFrame: speed, resize: resize, restore: restore)
            if count == 0 {
                let repeatAction = SKAction.repeatForever(animation)
                run(repeatAction, withKey: name)
            }
            else if count == 1 {
                run(animation, withKey: name)
            }
            else {
                let repeatAction = SKAction.repeat(animation, count: count)
                run(repeatAction, withKey: name)
            }
        }
    }
}
