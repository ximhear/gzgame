//
//  GameViewController.swift
//  gzgame
//
//  Created by gzonelee on 2021/10/16.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as? SKView {
            let scene = GameScene(size: CGSize(width: 1336, height: 1024))
//            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            scene.backgroundColor = .init(red: 105/255, green: 157/255, blue: 181/255, alpha: 1.0)
            view.presentScene(scene)
            view.ignoresSiblingOrder = false
            view.showsPhysics = false
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
