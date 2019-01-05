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
    var timeExtension: Double = 0.50 //change 0.50 to make game slower or faster
    
    var currentScore: Int = 1
    var lastScore: Int = 1
    
    var isSimulationFinished = false

    init(scene: GameScene) {
        self.scene = scene
    }
    
    init() {
        
    }
    
    
    func update(time: Double) {
        if nextTime == nil {
            nextTime = time + timeExtension
        }
        else {
            if time >= nextTime! {
                nextTime = time + timeExtension
                //print(time)
                checkForScore()
                self.scene.runSimulation()
            }
        }
    }
    
    private func checkForScore() {
        self.scene.currentScore.text = "Level: \(currentScore)"
        if scene.checkForScore() == true {
            if scene.nextLevel == true {
                currentScore += 1
                self.scene.currentScore.text = "Level: \(currentScore)"
                self.scene.carbonLabel.text = "\(scene.carbonPoint)"
                self.scene.userConfirmation()
                self.scene.isUserReady = false
                self.scene.count = 0
                self.scene.grid.isSimulationFinished = false
                self.scene.instructionToGo.isHidden = true
                
                if self.scene.isInsane {
                    self.scene.correct.fontColor = SKColor.red
                }
                else {
                    self.scene.correct.fontColor = SKColor.cyan
                }
                self.scene.correct.isHidden = false

                self.scene.nextLevel = false
                //self.scene.instructionToContinue.isHidden = false
                //print("Next Level")
            }
            if scene.gameOver == true {
                //print("Game Over")
                self.scene.isUserReady = false
                self.scene.count = 0
                self.scene.patternLength = 1
                self.scene.grid.isSimulationFinished = false
                
                self.scene.grid.showSolution(row: scene.correctRow, col: scene.correctCol)
                
                self.scene.userConfirmation()
                self.scene.instructionToContinue.isHidden = true
                self.scene.instructionToWait.isHidden = true
                self.scene.instructionToGo.isHidden = true
                
                if self.scene.isInsane {
                    self.scene.instructionToMenu.fontColor = SKColor.red
                }
                else {
                    self.scene.instructionToMenu.fontColor = SKColor.cyan
                }
                self.scene.instructionToMenu.isHidden = false
                
                self.scene.gameOver = false
            }
        }
        
    }
    
    func updateScore() {
        UserDefaults.standard.set(currentScore, forKey: "lastScore")
        UserDefaults.standard.set(scene.carbonPoint, forKey: "carbonPoint")
        
        self.scene.lastScore.text = "Last: \(UserDefaults.standard.integer(forKey: "lastScore"))"

        if currentScore > UserDefaults.standard.integer(forKey: "bestScore") {
            UserDefaults.standard.set(currentScore, forKey: "bestScore")
        }
        
        currentScore = 1
        self.scene.currentScore.text = "Level: 1"
        
        self.scene.bestScore.text = "Best Score: \(UserDefaults.standard.integer(forKey: "bestScore"))"
    }
    


    
    



}

