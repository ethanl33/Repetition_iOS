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
    var timeExtension: Double = 1.0 //change this value to make game slower or faster
    
    var currentScore: Int = 2 //put at 5 for testing
    
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
                scene.runSimulation()
            }
        }
    }
    
    private func checkForScore() {
        /*
        if scene.scorePos != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scorePos?.x)!) == y && Int((scene.scorePos?.y)!) == x {
                currentScore += 1
                scene.currentScore.text = "Score: \(currentScore)"
                generateNewPoint()
            }
        }
 */
        scene.currentScore.text = "Score: \(currentScore)"
    }

    
    



}

