//
//  GameManager.swift
//  Repetition
//
//  Created by Ethan Lee on 8/22/18.
//  Copyright © 2018 Ethan Lee. All rights reserved.
//

import SpriteKit

class GameManager {
    
    var scene: GameScene!
    
    var nextTime: Double?
    var timeExtension: Double = 0.8 //change this value to make game slower or faster
    
    var currentScore: Int = 1
    
    var isSimulationFinished = false

    init(scene: GameScene) {
        self.scene = scene
    }
    
    init() {
        
    }
    
    
    func update(time: Double) {
        if nextTime == nil {
            nextTime = time + timeExtension
        } else {
            if time >= nextTime! {
                nextTime = time + timeExtension
                //print(time)
                checkForScore()
                update()
                scene.runSimulation()
            }
        }
    }
    
    private func checkForScore() {
        scene.currentScore.text = "Score: \(currentScore)"
        if scene.checkForScore() == true {
            if scene.nextLevel == true {
                currentScore += 1
                scene.currentScore.text = "Score: \(currentScore)"
                print("Next Level")
            }
            if scene.gameOver == true {
                print("Game Over")
            }
        }
        
    }
    private func update() {

        if scene.gameOver == true {
            scene.isUserReady = false
            scene.count = 0
            scene.grid.isSimulationFinished = false
            //print("test")
            
            updateScore()
            
            //return to menu
            scene.currentScore.run(SKAction.scale(to: 0, duration: 0.4)) {
                self.scene.currentScore.isHidden = true
            }
            
            self.scene.gameLogo.isHidden = false
            self.scene.grid.isHidden = true
            self.scene.gameLogo.run(SKAction.move(to: CGPoint(x: 0, y: (self.scene.frame.size.height / 2) - 200), duration: 0.5)) {
                //self.scene.playButton.isHidden = false
                //self.scene.playButton.run(SKAction.scale(to: 1, duration: 0.3))
                self.scene.instructions.isHidden = false
                self.scene.instructions.run(SKAction.scale(to: 1, duration: 0.3))
                self.scene.touchPad.isHidden = false

                self.scene.bestScore.run(SKAction.move(to: CGPoint(x: 0, y: self.scene.gameLogo.position.y - 50), duration: 0.3))
            }
            scene.gameOver = false
        }
        if scene.nextLevel == true {
            scene.isUserReady = false
            scene.count = 0
            scene.grid.isSimulationFinished = false
            
            scene.nextLevel = false
            scene.userConfirmation()

        }
    }
    
    private func updateScore() {
        if currentScore > UserDefaults.standard.integer(forKey: "bestScore") {
            UserDefaults.standard.set(currentScore, forKey: "bestScore")
        }
        currentScore = 1
        scene.currentScore.text = "Score: 1"
        scene.bestScore.text = "Best Score: \(UserDefaults.standard.integer(forKey: "bestScore"))"
    }


    
    



}

