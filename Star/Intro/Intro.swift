//
//  Intro.swift
//  Star
//
//  Created by Victoria Andressa S. M. Faria on 10/03/20.
//  Copyright © 2020 Victoria Andressa Faria. All rights reserved.
//

import Foundation
import SpriteKit

class Intro: SKScene {
    
    var buttonPlay: SKSpriteNode?
    var background: SKSpriteNode?
    var logo: SKSpriteNode?
    var rocket: SKSpriteNode?
    var jupyter: SKSpriteNode?
    var bigPlanet: SKSpriteNode?
    var satellite: SKSpriteNode?
    
    
    override func didMove(to view: SKView) {
        
        buttonPlay?.isHidden = true
        background = self.childNode(withName: "background") as? SKSpriteNode
        
        logo = self.childNode(withName: "logo") as? SKSpriteNode
        
        rocket = self.childNode(withName: "rocket") as? SKSpriteNode
        let moveRocket = SKAction.move(to: CGPoint(x: 0, y: 128), duration: 3)
        self.rocket?.run(moveRocket)
        
        jupyter = self.childNode(withName: "jupyter") as? SKSpriteNode
        let rotateJupyterRight = SKAction.rotate(byAngle: -4.0, duration: 2)
        let rotateJupyterLeft = SKAction.rotate(byAngle: 4.0, duration: 2)
        let grupJupyter = SKAction.group([rotateJupyterRight, rotateJupyterLeft])
        let repeatForeverJupyter = SKAction.repeatForever(grupJupyter)
        self.jupyter?.run(repeatForeverJupyter)
        
        bigPlanet = self.childNode(withName: "bigPlanet") as? SKSpriteNode
        let moveBigPlanet = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 3)
        self.bigPlanet?.run(moveBigPlanet)
        
        satellite = self.childNode(withName: "satellite") as? SKSpriteNode
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    
}
