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
    var timeExtension: Double = 0.5 //change this value to make game slower or faster
    
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
                update()
                scene.runSimulation()
            }
        }
    }
    
    private func checkForScore() {
        scene.currentScore.text = "Level: \(currentScore)"
        if scene.checkForScore() == true {
            if scene.nextLevel == true {
                currentScore += 1
                scene.currentScore.text = "Level: \(currentScore)"
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

            scene.grid.showSolution(row: scene.correctRow, col: scene.correctCol)
            
            scene.userConfirmation()
            self.scene.instructionToContinue.isHidden = true
            self.scene.instructionToWait.isHidden = true
            self.scene.instructionToGo.isHidden = true
            self.scene.instructionToMenu.isHidden = false
            scene.gameOver = false
        }
        
        if scene.nextLevel == true {
            scene.isUserReady = false
            scene.count = 0
            scene.grid.isSimulationFinished = false
            self.scene.instructionToGo.isHidden = true
            
            scene.nextLevel = false
            scene.userConfirmation()
            self.scene.instructionToContinue.isHidden = false
        }
    }
    
    func updateScore() {
        UserDefaults.standard.set(currentScore, forKey: "lastScore")
        scene.lastScore.text = "Last: \(UserDefaults.standard.integer(forKey: "lastScore"))"

        if currentScore > UserDefaults.standard.integer(forKey: "bestScore") {
            UserDefaults.standard.set(currentScore, forKey: "bestScore")
        }
        
        currentScore = 1
        scene.currentScore.text = "Level: 1"
        scene.bestScore.text = "Best Score: \(UserDefaults.standard.integer(forKey: "bestScore"))"
        
    }


    
    



}

