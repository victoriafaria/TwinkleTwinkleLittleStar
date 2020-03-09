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
    
    var bees: [SKSpriteNode] = []
    let drawManager = DrawManager()
    
    override func didMove(to view: SKView) {
        
        guard let bee = self.childNode(withName: "bee") as? SKSpriteNode,
            let bee2 = self.childNode(withName: "bee2") as? SKSpriteNode,
            let bee3 = self.childNode(withName: "bee3") as? SKSpriteNode else {fatalError("some bee was not found")}
        
        bees.append(contentsOf: [bee, bee2, bee3])
        
        addAnimation()
    }
    
    func addAnimation()  {
        let beeLeft = SKAction.rotate(byAngle: -0.5, duration: 0.1)
        let beeRight = SKAction.rotate(byAngle: 0.5, duration: 0.1)
        
        let moveSequence = SKAction.sequence([beeLeft,beeRight])
        
        let beeBounce = SKAction.repeatForever(moveSequence)
        
        bees.forEach { (bee) in
            bee.run(beeBounce)
        }
        
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("asd")
        for touch in touches {
            let location = touch.location(in:self)
            let node = bees.first { (element) -> Bool in
                return element.contains(location)
            }
            
            if let node = node {
                drawManager.startDraw(node)
            }
            
        }
    }


    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches as! Set<UITouch>) {
            var location = touch.location(in: self)
            
            if let node = bees.first(where: { (element) -> Bool in
                return element.contains(location)
            }) {
                // comparar os nós last e o nome
                // parar o desenho
                // iniciar o novo desenho a partir do novo no
            }
            drawManager.drawLine(location, scene: self)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

