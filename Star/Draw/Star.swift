//
//  Star.swift
//  Star
//
//  Created by Victoria Andressa S. M. Faria on 10/03/20.
//  Copyright © 2020 Victoria Andressa Faria. All rights reserved.
//

import Foundation
import SpriteKit

class Star: SKSpriteNode {
    
    var alreadyLinked = false
    
    static func == (a: Star, b:  Star) -> Bool {
        return a.name == b.name 
    }
}

