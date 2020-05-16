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
        background?.self.childNode(withName: "background") as? SKSpriteNode
        logo.self?.childNode(withName: "logo") as? SKSpriteNode
        rocket.self?.childNode(withName: "rocket") as? SKSpriteNode
        jupyter?.self.childNode(withName: "jupyter") as? SKSpriteNode
        bigPlanet.self?.childNode(withName: "bigPlanet") as? SKSpriteNode
        satellite.self?.childNode(withName: "bigPlanet") as? SKSpriteNode
    }
    
}
