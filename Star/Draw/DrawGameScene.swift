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
    
    override func didMove(to view: SKView) {
        
        for i in 1...8 {
            if let star = self.childNode(withName: "\(String(describing: Star.self))\(i)") as? Star {
                stars.append(star)
            }
        }
        
        buttonNext = self.childNode(withName: "buttonNext") as? SKSpriteNode
        buttonNext?.isHidden = true
        
        addAnimation()
    }
    
    func addAnimation()  {
        let beeLeft = SKAction.rotate(byAngle: -0.5, duration: 0.1)
        let beeRight = SKAction.rotate(byAngle: 0.5, duration: 0.1)
        
        let moveSequence = SKAction.sequence([beeLeft,beeRight])
        
        let beeBounce = SKAction.repeatForever(moveSequence)
        
        stars.forEach { (bee) in
            bee.run(beeBounce)
        }
        
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in:self)
            let node = stars.first { (element) -> Bool in
                return element.contains(location)
            }
 
            if let node = node, !node.alreadyLinked {
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
            
            if let node = stars.first(where: { (element) -> Bool in
                return element.contains(location)
            }) {
                if drawManager.compareLastDrawNode(to: node), !node.alreadyLinked  {
                    drawManager.restartDraw(at: node)
                    // colocar musica conectando estrelas
                    // mudar asset da estrela
                }
                
                if countLinked() == stars.count-1 {
                    node.alreadyLinked = true
                    drawManager.stopDraw()
                    // fim de jogo
                    // musica minhas crianças
                    // aparecer botão
                    buttonNext?.isHidden = false
                }
            }
            drawManager.drawLine(location, scene: self)
        }
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

