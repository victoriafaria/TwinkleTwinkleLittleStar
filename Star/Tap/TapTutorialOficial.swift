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
    var buttonTutorialTap: SKSpriteNode?
    var tutorialDone = false
    
    let tapRecognizer = UITapGestureRecognizer()
    
    override func didMove(to view: SKView) {
        
        buttonTutorialTap = self.childNode(withName: "buttonTutorialTap") as? SKSpriteNode
        buttonTutorialTap?.isHidden = true
        
        starSleepTutorial = self.childNode(withName: "starSleepTutorial") as? SKSpriteNode
        
//      função de tap
        tapRecognizer.addTarget(self, action: #selector(TapTutorialOficial.tap))
        self.view!.addGestureRecognizer(tapRecognizer)
        
    }

    @objc func tap(_ gesture:UIPinchGestureRecognizer) {

        let location = gesture.location(in: self.view!)
        let point = convertPoint(fromView: location)

        let touchedNode = self.atPoint(point)
        starSleepTutorial = touchedNode as? SKSpriteNode

        if starSleepTutorial?.name == "starSleepTutorial" {
            let textureLightUp = SKTexture(imageNamed: "starLightUp")
            starSleepTutorial?.texture = textureLightUp
            tutorialDone = true
            buttonTutorialTap?.isHidden = false
            print("trocou")
            //adicionar musica do tap
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let location = touch.location(in:self)
//
//            let touchedNode = self.atPoint(location)
//            starSleepTutorial = touchedNode as? SKSpriteNode
//
//            if starSleepTutorial?.name == "starSleepTutorial" {
//                let textureLightUp = SKTexture(imageNamed: "starLightUp")
//                starSleepTutorial?.texture = textureLightUp
//                tutorialDone = true
//                buttonNext?.isHidden = false
//                print("trocou de estrela")
//
//                //adicionar musica do tap
//            }
//        }
//    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if let buttonTutorialTap = buttonTutorialTap, !buttonTutorialTap.isHidden, buttonTutorialTap.contains(location) {
                let changeScene = SKAction.run {
                    if let scene = TapGameScene (fileNamed: "TapGameScene"){
                        scene.scaleMode = .aspectFit
                        self.view?.ignoresSiblingOrder = false
                        self.view?.presentScene(scene)
                    }
                }
                buttonTutorialTap.run(changeScene)
            }
        }
    }
    
    
} // end class
