//
//  TapTutorial.swift
//  Star
//
//  Created by Victoria Andressa S. M. Faria on 11/03/20.
//  Copyright © 2020 Victoria Andressa Faria. All rights reserved.
//

import Foundation
import SpriteKit

class TapTutorial: SKScene {
    
    var starSleepTutorial: SKSpriteNode?
    var buttonNext: SKSpriteNode?
    var tutorialDone = false
    
    override func didMove(to view: SKView) {
        
        starSleepTutorial = self.childNode(withName: "starSleepTutorial") as? SKSpriteNode
        buttonNext?.isHidden = true
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in:self)
            
            let touchedNode = self.atPoint(location)
                    starSleepTutorial = touchedNode as? SKSpriteNode
                    
                    if starSleepTutorial?.name == "starSleepTutorial" {
                        let textureLightUp = SKTexture(imageNamed: "starLightUp")
                        starSleepTutorial?.texture = textureLightUp
                        tutorialDone = true
                        buttonNext?.isHidden = false
                        //adicionar musica do tap
                    }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            // trocar de tela
            if tutorialDone {
                if let buttonNext = buttonNext, !buttonNext.isHidden, buttonNext.contains(location) {
                    let changeScene = SKAction.run {
                        if let scene = TapGameScene (fileNamed: "TapGameScene"){
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
