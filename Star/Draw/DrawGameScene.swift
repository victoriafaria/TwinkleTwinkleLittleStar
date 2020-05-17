//
//  DrawGameScene.swift
//  Star
//
//  Created by Victoria Andressa S. M. Faria on 06/03/20.
//  Copyright © 2020 Victoria Andressa Faria. All rights reserved.
//

import SpriteKit
import UIKit
import CoreGraphics

class DrawGameScene: SKScene {
    
    var stars: [Star] = []
    let drawManager = DrawManager()
    var buttonNext: SKSpriteNode?
    
    var background: SKSpriteNode?
    
    var startStar: Star!
    var endStar: Star!
    
    override func didMove(to view: SKView) {
        
        for i in 1...18 {
            if let star = self.childNode(withName: "\(String(describing: Star.self))\(i)") as? Star {
                stars.append(star)
            }
        }
        
        buttonNext = self.childNode(withName: "buttonNext") as? SKSpriteNode
        buttonNext?.isHidden = true
        
        background = self.childNode(withName: "background") as? SKSpriteNode
        
        //        nextStar()
        
        self.startStar = stars[drawIndex]
        
        drawManager.lastDrawNode = self.startStar
        
        addAnimation(star: self.startStar)
        
    }
    
    func addAnimation(star: Star)  {
        print(star.name)
        let left = SKAction.rotate(byAngle: -0.5, duration: 0.1)
        let right = SKAction.rotate(byAngle: 0.5, duration: 0.1)
        
        let scale = SKAction.scale(by: 2, duration: 0.1)
        
        let moveSequence = SKAction.sequence([left,right])
        
        let bounce = SKAction.repeatForever(moveSequence)
        let group = SKAction.group([bounce, scale])
        
        star.run(group)
        
    }
    
    var drawIndex: Int = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in:self)
            
            
            for node in self.nodes(at: location) {
                if node == startStar && !startStar.alreadyLinked {
                    self.startStar.alreadyLinked = true
                    drawManager.startDraw(self.startStar)
                    if drawIndex < stars.count {
                        drawIndex += 1
                    }
                    self.endStar = stars[drawIndex] // FIXME PLEASE Out of bounds
                    self.startStar.removeAllActions()
                    addAnimation(star: self.endStar)
                    break
                }
            }
        }
    }
    
    func countLinked() -> Int {
        var count = 0
        for star in stars {
            if star.alreadyLinked {
                count += 1
            }
        }
        return count
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches as! Set<UITouch>) {
            var location = touch.location(in: self)
            drawManager.drawLine(location, scene: self)
            
            if self.endStar.contains(location) {
                self.endStar.alreadyLinked = true
                self.endStar.removeAllActions()
                drawManager.restartDraw(at: self.endStar)
                self.startStar = endStar
                
                let soundAction = SKAction.playSoundFileNamed("stars.mp3", waitForCompletion: false)
                run(soundAction)
            
                if drawIndex < stars.count {
                    drawIndex += 1
                }
                
                // last start connected ?
                if drawIndex != stars.count {
                    self.endStar = stars[drawIndex] //FIXME PLEASE Out of bounds
                    addAnimation(star: self.endStar)
                } else {
                    // last one
                    endDrawGame(self.endStar)
                }
                break
            }
        }
    }
    
    func endDrawGame(_ nextStar: Star) {
        if countLinked() == stars.count {
            nextStar.alreadyLinked = true
            drawManager.stopDraw()
            
            showMoon()
            // musica minhas crianças
            // aparecer botão
            buttonNext?.isHidden = false
        }
    }
    
    func showMoon() {
        let moon = self.childNode(withName: "moon") as? SKSpriteNode
        moon?.alpha = 1
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if let buttonNext = buttonNext, !buttonNext.isHidden, buttonNext.contains(location) {
                let changeScene = SKAction.run {
                    if let scene = PinchTutorial (fileNamed: "PinchTutorial"){
                        scene.scaleMode = .aspectFit
                        self.view?.ignoresSiblingOrder = false
                        self.view?.presentScene(scene)
                    }
                }
                let soundActionButton = SKAction.playSoundFileNamed("button.mp3", waitForCompletion: false)
                buttonNext.run(SKAction.sequence([soundActionButton,changeScene]))
            }
        }
    }
    
}

