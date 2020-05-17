//
//  DrawTutorial.swift
//  Star
//
//  Created by Victoria Andressa S. M. Faria on 10/03/20.
//  Copyright © 2020 Victoria Andressa Faria. All rights reserved.
//

import Foundation
import SpriteKit

class DrawTutorial: SKScene {
    
    var starTutorial: Star?
    var star1: Star?
    var star2: Star?
//    var starCopy: Star!
    
    var tutorialDone = false
    var buttonNext: SKSpriteNode?
    
    let drawManager = DrawManager()
    
    override func didMove(to view: SKView) {
        
        starTutorial = self.childNode(withName: "starTutorial") as? Star
        star1 = self.childNode(withName: "star1") as? Star
        star2 = self.childNode(withName: "star2") as? Star
        
        buttonNext = self.childNode(withName: "buttonNext") as? SKSpriteNode
        buttonNext?.isHidden = true
        
        tutorialAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in:self)
            
            if let node = nodeTouched(location), !node.alreadyLinked {
                
                drawManager.startDraw(node)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            
            if let node = nodeTouched(location), drawManager.compareLastDrawNode(to: node) {
                drawManager.stopDraw(at: node)
                tutorialDone = true
                buttonNext?.isHidden = false
                stopTutorialAnimation()
                //colocar minhas crianças (música)
            }
            drawManager.drawLine(location, scene: self)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        drawManager.stopDraw()
        
        // mudança de scene
        for touch in touches {
            let location = touch.location(in: self)
            if tutorialDone {
                if let buttonNext = buttonNext, buttonNext.contains(location) {
                    //mudança de scene
                    let changeScene = SKAction.run {
                        if let scene = DrawGameScene (fileNamed: "DrawGameScene"){
                            scene.scaleMode = .aspectFit
                            self.view?.ignoresSiblingOrder = false
                            self.view?.presentScene(scene)
                        }
                    }
                    buttonNext.run(changeScene)
                }
            } else {
                star1?.alreadyLinked = false
                star2?.alreadyLinked = false
            }
        }
    }
    
    func stopTutorialAnimation() {
        if let starCopy = self.childNode(withName: "starCopy") {
            starCopy.removeAllActions()
            starCopy.removeFromParent()
        }
        
        
    }
    
    func tutorialAnimation() {
        guard let star1 = star1, let star2 = star2, let starCopy = star1.copy() as? Star else { return }
        
        starCopy.name = "starCopy"
        let move = SKAction.move(to: star2.position, duration: 2)
        let moveBack = SKAction.move(to: star1.position, duration: 0)
        let sequence = SKAction.sequence([move,moveBack])
        self.addChild(starCopy)
        
        starCopy.run(SKAction.repeatForever(sequence), withKey: "starRun")
        
    }
    
    func nodeTouched(_ location: CGPoint) -> Star? {
        
        var node: Star? = nil
        
        if let star1 = star1,
        star1.contains(location) {
            node = star1
        } else if let star2 = star2,
        star2.contains(location) {
            node = star2
        }
        return node
        // parar animacao da estrela
    }
    
}
