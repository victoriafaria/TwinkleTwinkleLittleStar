//
//  TapGameScene.swift
//  Star
//
//  Created by Victoria Andressa S. M. Faria on 11/03/20.
//  Copyright © 2020 Victoria Andressa Faria. All rights reserved.
//

import Foundation
import SpriteKit

class TapGameScene: SKScene {
    
    var stars: [SKSpriteNode] = []
    var buttonNext: SKSpriteNode?
    var startTapped: SKSpriteNode? = nil
    
    override func didMove(to view: SKView) {
        
        buttonNext = self.childNode(withName: "buttonNext") as? SKSpriteNode
        buttonNext?.isHidden = true
        
        for i in 1...10 {
            if let star = self.childNode(withName: "starSleep\(i)") as? SKSpriteNode {
                stars.append(star)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let location = touches.first?.location(in: self) else {return}
        
        //Qual estrela foi tapped + troca de texture
        startTapped = nil
        stars.forEach { star in
            if star.contains(location) {
                startTapped = star
            }
        }
        if self.startTapped != nil {
            starTapped()
        }
        
        //Quantas estrelas foram tapped
        var tappedCount = 0
        stars.forEach { star in
            if star.name?.contains("Tapped") == true {
                tappedCount += 1
            }
        }
        if tappedCount == stars.count {
            buttonNext?.isHidden = false
        }
        
        if let buttonNext = buttonNext, !buttonNext.isHidden, buttonNext.contains(location) {
            let changeScene = SKAction.run {
                if let scene = EndScene(fileNamed: "EndScene"){
                    scene.scaleMode = .aspectFit
                    self.view?.ignoresSiblingOrder = false
                    self.view?.presentScene(scene)
                }
            }
            buttonNext.run(changeScene)
        }
    }
    
    private func starTapped() {
        let textureLightUp = SKTexture(imageNamed: "starHappy")
        startTapped?.texture = textureLightUp
        startTapped?.size = CGSize(width: 65, height: 60)
        startTapped?.name? += "Tapped"
        print("trocou de estrela")
        //adicionar musica do tap
    }
    
    
} // end class
