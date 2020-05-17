//
//  EndScene.swift
//  Star
//
//  Created by Victoria Andressa S. M. Faria on 17/05/20.
//  Copyright © 2020 Victoria Andressa Faria. All rights reserved.
//

import SpriteKit


class EndScene: SKScene {
    
    var starHappy: SKSpriteNode?
    var buttonAbout: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        starHappy = self.childNode(withName: "starVeryHappy") as? SKSpriteNode
        buttonAbout = self.childNode(withName: "buttonAbout") as? SKSpriteNode

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let location = touches.first?.location(in: self) else {return}
        
        if buttonAbout?.contains(location) == true {
            let changeScene = SKAction.run {
                if let scene = AboutScene(fileNamed: "AboutScene"){
                    scene.scaleMode = .aspectFit
                    self.view?.ignoresSiblingOrder = false
                    self.view?.presentScene(scene)
                }
            }
            buttonAbout?.run(changeScene)
        }
        
    }
}
