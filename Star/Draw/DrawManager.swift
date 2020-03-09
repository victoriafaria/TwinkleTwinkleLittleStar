//
//  DrawMenager.swift
//  Star
//
//  Created by Victoria Andressa S. M. Faria on 06/03/20.
//  Copyright © 2020 Victoria Andressa Faria. All rights reserved.
//

import Foundation
import SpriteKit


class DrawManager {
    
    var isDrawing = false
    var lastPoint: CGPoint!
    var newPoint: CGPoint!
    var myLine:SKShapeNode!
    
    var lastDrawNode: SKSpriteNode?{
        willSet{
            if newValue == nil {
                isDrawing = false
            }else {
                isDrawing = true
            }
        }
    }
    
    func startDraw(_ node: SKSpriteNode) {
        lastDrawNode = node
        isDrawing = true
        newPoint = node.position
        lastPoint = node.position
    }
    
    func stopDraw(at node: SKSpriteNode) {
        lastDrawNode = node
//      let nodeCenterPoint = CGPoint(x: node.frame.midX, y: node.frame.midY)
    }
    
    func drawLine(_ location: CGPoint, scene: SKScene) {
        newPoint = location
        
        deleteLineToReDraw()
        
        let pathToDraw:CGMutablePath = CGMutablePath()
        myLine = SKShapeNode()
        
        pathToDraw.move(to: lastPoint)
        pathToDraw.addLine(to: newPoint)
        
        myLine.path = pathToDraw
        myLine.strokeColor = SKColor.white
        scene.addChild(myLine)
    }
    
    func compareLastDrawNode(to node: SKSpriteNode) -> Bool {
        return node.name != lastDrawNode?.name
    }
    
    func deleteLineToReDraw() {
        if let line = myLine {
            line.removeFromParent()
        }
    }
    
}

