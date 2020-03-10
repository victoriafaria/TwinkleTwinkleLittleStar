//
//  PinchTutorial.swift
//  Star
//
//  Created by Victoria Andressa S. M. Faria on 10/03/20.
//  Copyright © 2020 Victoria Andressa Faria. All rights reserved.
//

import Foundation
import SpriteKit

class PinchTutorial: SKScene {
    
    var cloudTutorial: SKSpriteNode?
    var tutorialDone = false
    
    var buttonNext: SKSpriteNode?
    let pinchRecognizer = UIPinchGestureRecognizer()
    
    
    override func didMove(to view: SKView) {
        
        cloudTutorial = self.childNode(withName: "cloudTutorial") as? SKSpriteNode
        buttonNext = self.childNode(withName: "buttonNext") as? SKSpriteNode
        
        // função de pinch
        pinchRecognizer.addTarget(self, action: #selector(PinchGameScene.pinch))
        self.view!.addGestureRecognizer(pinchRecognizer)
        
    }

    // função pinch
        @objc func pinch(_ gesture:UIPinchGestureRecognizer) {
            let location = gesture.location(in: self.view!)
            let point = convertPoint(fromView: location)
            
            if let cloudTutorial = cloudTutorial, cloudTutorial.contains(point) {
                cloudTutorial.removeFromParent()
                tutorialDone = true
            }
        }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if tutorialDone {
                if let buttonNext = buttonNext, buttonNext.contains(location) {
                    let changeScene = SKAction.run {
                        if let scene = PinchGameScene (fileNamed: "PinchGameScene"){
                            scene.scaleMode = .aspectFill
                            self.view?.ignoresSiblingOrder = false
                            self.view?.presentScene(scene)
                        }
                    }
                    buttonNext.run(changeScene)
                }
            }
        }
    }
    
}

