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
    
    
    override func didMove(to view: SKView) {
        
        for i in 1...18 {
            if let star = self.childNode(withName: "\(String(describing: Star.self))\(i)") as? Star {
                stars.append(star)
            }
        }
        
        buttonNext = self.childNode(withName: "buttonNext") as? SKSpriteNode
        buttonNext?.isHidden = true
        
        background = self.childNode(withName: "background") as? SKSpriteNode
        
        nextStar()
        
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in:self)
            let node = nextStar()
            if node.contains(location), !node.alreadyLinked {
                drawManager.startDraw(node)
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
            
            let next = nextStar()
            if next.contains(location) {
                
                if drawManager.compareLastDrawNode(to: next), !next.alreadyLinked  {
                    drawManager.restartDraw(at: next)
                    // colocar musica conectando estrelas
                    // mudar asset da estrela
                }
                endDrawGame(next)
            }
            drawManager.drawLine(location, scene: self)
        }
    }
    
    
    var nextStarIndex: Int = 0
    
    func nextStar() -> Star {
        
        var nextStar: Star = stars.first!
        if let lastNode = drawManager.lastDrawNode,
            let index = stars.firstIndex(of: lastNode),
            stars.indices.contains(index+1){
            nextStar = stars[index+1]
        }
        addAnimation(star: nextStar)
        return nextStar
    }
    
    
    func endDrawGame(_ nextStar: Star) {
        if countLinked() == stars.count-1 {
            nextStar.alreadyLinked = true
            // drawManager.stopDraw()
            
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
                buttonNext.run(changeScene)
            }
        }
    }
    
}

