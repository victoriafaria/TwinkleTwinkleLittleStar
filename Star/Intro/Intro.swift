//
//  Intro.swift
//  Star
//
//  Created by Victoria Andressa S. M. Faria on 10/03/20.
//  Copyright © 2020 Victoria Andressa Faria. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation


private let AudioManagerInstance = AudioPlayer()

class AudioPlayer {
    
    public class func sharedInstance() -> AudioPlayer {
        return AudioManagerInstance
    }
    var musicPlayer: AVAudioPlayer!
    
    public func playMusic(fileName: String, withExtension type: String = "mp3") {
        if let url = Bundle.main.url(forResource: fileName, withExtension: type) {
            musicPlayer = try? AVAudioPlayer(contentsOf: url)
            musicPlayer.numberOfLoops = -1
            musicPlayer.volume = 0.2
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        }
    }
    
    public func stopMusic() {
        if musicPlayer != nil && musicPlayer!.isPlaying {
            musicPlayer.currentTime = 0
            musicPlayer.stop()
        }
    }
}

class Intro: SKScene {
    
    let audioPlayer = AudioPlayer.sharedInstance()
    var buttonPlay: SKSpriteNode?
    var background: SKSpriteNode?
    var logo: SKSpriteNode?
    var rocket: SKSpriteNode?
    var jupyter: SKSpriteNode?
    var bigPlanet: SKSpriteNode?
    var satellite: SKSpriteNode?
    
    
    override func didMove(to view: SKView) {
        
        audioPlayer.playMusic(fileName: "bensound-smile")
        
        
        buttonPlay = self.childNode(withName: "buttonPlay") as? SKSpriteNode
        buttonPlay?.alpha = 0.0
        let waitPlay = SKAction.wait(forDuration: 1.5)
        let appearPlay = SKAction.fadeAlpha(by: 1.0, duration: 1.5)
        self.buttonPlay?.run(SKAction.sequence([waitPlay,appearPlay]))
        
        
        background = self.childNode(withName: "background") as? SKSpriteNode
        
        logo = self.childNode(withName: "logo") as? SKSpriteNode
        
        rocket = self.childNode(withName: "rocket") as? SKSpriteNode
        let moveRocket = SKAction.move(to: CGPoint(x: 0, y: 128), duration: 3)
        let rotateRocketRight = SKAction.move(to: CGPoint(x: 0, y: 130), duration: 1)
        let rotateJRocketLeft = SKAction.move(to: CGPoint(x: 0, y: 140), duration: 1)
        let sequenceRocket = SKAction.sequence([moveRocket,rotateRocketRight, rotateJRocketLeft])
        let repeatForeverRocket = SKAction.repeatForever(sequenceRocket)
        self.rocket?.run(repeatForeverRocket)
        
        jupyter = self.childNode(withName: "jupyter") as? SKSpriteNode
        let rotateJupyterRight = SKAction.rotate(byAngle: -0.5, duration: 4)
        let rotateJupyterLeft = SKAction.rotate(byAngle: 0.5, duration: 4)
        let sequenceJupyter = SKAction.sequence([rotateJupyterRight, rotateJupyterLeft])
        let repeatForeverJupyter = SKAction.repeatForever(sequenceJupyter)
        self.jupyter?.run(repeatForeverJupyter)
        
        bigPlanet = self.childNode(withName: "bigPlanet") as? SKSpriteNode
        let moveBigPlanet = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 3)
        self.bigPlanet?.run(moveBigPlanet)
        
        satellite = self.childNode(withName: "satellite") as? SKSpriteNode
        let rotateSatelliteRight = SKAction.rotate(byAngle: -4.0, duration: 4)
        let rotateSatelliteLeft = SKAction.rotate(byAngle: 1.0, duration: 2)
        let sequenceSatellite = SKAction.sequence([rotateSatelliteRight, rotateSatelliteLeft])
        let repeatForeverSatellite = SKAction.repeatForever(sequenceSatellite)
        self.satellite?.run(repeatForeverSatellite)
    }
    
    

    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if let buttonPlay = buttonPlay, buttonPlay.alpha == 1.0, buttonPlay.contains(location) {
                let changeScene = SKAction.run {
                    if let scene = DrawTutorial (fileNamed: "DrawTutorial"){
                        scene.scaleMode = .aspectFit
                        self.view?.ignoresSiblingOrder = false
                        self.view?.presentScene(scene)
                    }
                }
                let soundActionButton = SKAction.playSoundFileNamed("button.mp3", waitForCompletion: false)
                buttonPlay.run(SKAction.sequence([soundActionButton,changeScene]))
            }
        }
    }
    
}
