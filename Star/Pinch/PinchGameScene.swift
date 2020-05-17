//
//  PinchGameScene.swift
//  Star
//
//  Created by Victoria Andressa S. M. Faria on 08/03/20.
//  Copyright © 2020 Victoria Andressa Faria. All rights reserved.
//

import Foundation
import SpriteKit

class PinchGameScene: SKScene {
    
    var clouds: [SKSpriteNode] = []
    let pinchRecognizer = UIPinchGestureRecognizer()
    var buttonNext: SKSpriteNode?
  
    
    override func didMove(to view: SKView) {
        
        buttonNext = self.childNode(withName: "buttonNext") as? SKSpriteNode
        buttonNext?.isHidden = true
        
        for i in 1...10 {
            if let cloud = self.childNode(withName: "cloud\(i)") as? SKSpriteNode {
                clouds.append(cloud)
            }
        }

        // função de pinch
        pinchRecognizer.addTarget(self, action: #selector(PinchGameScene.pinch))
        self.view!.addGestureRecognizer(pinchRecognizer)
        
    }
    
    // função pinch
    @objc func pinch(_ gesture:UIPinchGestureRecognizer) {
//        if gesture.state == .ended {
//        }
        let location = gesture.location(in: self.view!)
        let point = convertPoint(fromView: location)
        
        let node = clouds.first { (element) -> Bool in
            return element.contains(point)
        }
        node?.removeFromParent()
        clouds.removeAll { (element) -> Bool in
            return element == node
        }
        
        if clouds.isEmpty {
            print("cabo as nuven mano")
            buttonNext?.isHidden = true
        }
    }
    
    
    
}
