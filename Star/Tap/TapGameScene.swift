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
    let tapRecognizer = UITapGestureRecognizer()
    
    override func didMove(to view: SKView) {
        
        
        for i in 1...10 {
            if let star = self.childNode(withName: "starSleep\(i)") as? SKSpriteNode {
                stars.append(star)
            }
        }
        
        // função de tap
          tapRecognizer.addTarget(self, action: #selector(TapGameScene.tap))
          self.view!.addGestureRecognizer(tapRecognizer)
    }
    
    // função pinch
    @objc func tap(_ gesture:UITapGestureRecognizer) {
        let location = gesture.location(in: self.view!)
        let point = convertPoint(fromView: location)
        
        let node = stars.first { (element) -> Bool in
            return element.contains(point)
        }
        node?.removeFromParent()
        stars.removeAll { (element) -> Bool in
            return element == node
        }
        
        if stars.isEmpty {
            print("cabo as estrela mano")
//            buttonNext?.isHidden = false
        }
    }
  
    
    
} // end class
