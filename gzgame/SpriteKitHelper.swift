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
}
