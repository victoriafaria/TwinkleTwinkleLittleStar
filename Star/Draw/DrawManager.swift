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
    var lastPoint: CGPoint?
    var newPoint: CGPoint?
    var myLine: SKShapeNode!
    var initialNode: Star?
    
    var lastDrawNode: Star?{
        willSet{
            if newValue == nil {
                isDrawing = false
            }else {
                isDrawing = true
            }
        }
    }
    
    func startDraw(_ node: Star) {
        lastDrawNode = node
        initialNode = node
        isDrawing = true
        newPoint = node.position
        lastPoint = node.position
    }
    
    func stopDraw(at node: Star){
        node.alreadyLinked = true
        restartDraw(at: node)
        isDrawing = false
    }
    
    func stopDraw() {
        initialNode?.alreadyLinked = true
        if let initialNode = self.initialNode {
            restartDraw(at: initialNode)
        }
        isDrawing = false
    }
    
    func restartDraw(at node: Star) {
        lastDrawNode?.alreadyLinked = true
        lastDrawNode = node
        let nodeCenterPoint = CGPoint(x: node.frame.midX, y: node.frame.midY)
        drawLine(nodeCenterPoint, scene: node.scene!)
        myLine = nil
        newPoint = node.position
        lastPoint = node.position
    }
    
    func drawLine(_ location: CGPoint, scene: SKScene) {
        if isDrawing {
            newPoint = location
            deleteLineToReDraw()
            
            let pathToDraw:CGMutablePath = CGMutablePath()
            myLine = SKShapeNode()
            myLine.glowWidth = 3
//            myLine.lineWidth = 5
            myLine.strokeColor = SKColor.white
            
            if let lastPoint = lastPoint, let newPoint = newPoint{
                pathToDraw.move(to: lastPoint)
                pathToDraw.addLine(to: newPoint)
            }
            
            myLine.path = pathToDraw
            scene.addChild(myLine)
            
        }
    }
    
    func compareLastDrawNode(to node: Star) -> Bool {
        return node.name != lastDrawNode?.name
    }
    
    func deleteLineToReDraw() {
        if let line = myLine {
            line.removeFromParent()
        }
    }
    
}

