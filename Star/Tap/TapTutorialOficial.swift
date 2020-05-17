//
//  TapTutorial.swift
//  Star
//
//  Created by Victoria Andressa S. M. Faria on 11/03/20.
//  Copyright © 2020 Victoria Andressa Faria. All rights reserved.
//

import Foundation
import SpriteKit

class TapTutorialOficial: SKScene {
    
    var starSleepTutorial: SKSpriteNode?
    var buttonNext: SKSpriteNode?
    

    
    override func didMove(to view: SKView) {
        
        buttonNext = self.childNode(withName: "buttonNext") as? SKSpriteNode
        buttonNext?.isHidden = true
        
        starSleepTutorial = self.childNode(withName: "starSleepTutorial") as? SKSpriteNode
        
    }
    
    private func starTapped() {
        let textureLightUp = SKTexture(imageNamed: "starHappy")
        starSleepTutorial?.texture = textureLightUp
        starSleepTutorial?.size = CGSize(width: 110, height: 100)
        buttonNext?.isHidden = false
        print("trocou de estrela")
        let soundAction = SKAction.playSoundFileNamed("tap.mp3", waitForCompletion: false)
        run(soundAction)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in  touches {
            let location = touch.location(in: self)
            if self.starSleepTutorial != nil, starSleepTutorial!.contains(location) {
                starTapped()
            } else if let buttonNext = buttonNext, !buttonNext.isHidden, buttonNext.contains(location) {
                let changeScene = SKAction.run {
                    if let scene = TapGameScene(fileNamed: "TapGameScene"){
                        self.view?.ignoresSiblingOrder = false
                        scene.scaleMode = .aspectFit
                        self.view?.presentScene(scene)
                    }
                }
                let soundActionButton = SKAction.playSoundFileNamed("button.mp3", waitForCompletion: false)
                buttonNext.run(SKAction.sequence([soundActionButton,changeScene]))
            }
        }
    }
    
} // end class
