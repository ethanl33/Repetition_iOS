//
//  GameScene.swift
//  Repetition
//
//  Created by Ethan Lee on 8/22/18.
//  Copyright © 2018 Ethan Lee. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    var touchPad: SKShapeNode!
    var startLevel: SKShapeNode!
    var startButton: SKShapeNode!
    var endButton: SKShapeNode!
    
    var gameLogo: SKLabelNode!
    var bestScore: SKLabelNode!
    var correct: SKLabelNode!
    var instructionToStart: SKLabelNode!
    var instructionToWait: SKLabelNode!
    var instructionToGo: SKLabelNode!
    var instructionToContinue: SKLabelNode!
    var instructionToMenu: SKLabelNode!
    var currentScore: SKLabelNode!
    var lastScore: SKLabelNode!
    
    var game: GameManager!
    
    var correctRow: Int!
    var correctCol: Int!

    var grid: Grid!
    var isUserReady = false
    var nextLevel = false
    var gameOver = false
    var count: Int = 0
    var patternLength: Int = 1

    
    override func didMove(to view: SKView) {
        initializeMenu()
        game = GameManager(scene: self)
        initializeGameView()
    }
    
    private func initializeGameView() {
        currentScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        currentScore.zPosition = 1
        currentScore.position = CGPoint(x: 0, y: (frame.size.height / -2) + 61)
        currentScore.fontSize = 41
        currentScore.isHidden = true
        currentScore.text = "Level: 1"
        currentScore.fontColor = SKColor.white
        self.addChild(currentScore)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        game.update(time: currentTime)
    }
    
    private func initializeMenu() {
        //Create game title
        gameLogo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0, y: (frame.size.height / 2) - 201)
        gameLogo.fontSize = 61
        gameLogo.text = "Repetition"
        //gameLogo.fontColor = SKColor(red: 36/255, green: 93/255, blue: 104/255, alpha: 1)
        //gameLogo.fontColor = SKColor(red: 245/255, green: 208/255, blue: 76/255, alpha: 1)
        gameLogo.fontColor = SKColor.cyan
        self.addChild(gameLogo)
        
        //Create best score label
        bestScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0, y: gameLogo.position.y - 71)
        bestScore.fontSize = 41
        //bestScore.text = "Best Score: 0"
        bestScore.text = "Best Score: \(UserDefaults.standard.integer(forKey: "bestScore"))"
        bestScore.fontColor = SKColor.white
        self.addChild(bestScore)
        
        lastScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        lastScore.zPosition = 1
        lastScore.position = CGPoint(x: 0, y: bestScore.position.y - 51)
        lastScore.fontSize = 31
        //lastScore.text = "Score: 0"
        lastScore.text = "Last: \(UserDefaults.standard.integer(forKey: "lastScore"))"
        lastScore.fontColor = SKColor.white
        self.addChild(lastScore)
        
        //Create game title
        instructionToStart = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        instructionToStart.zPosition = 1
        instructionToStart.position = CGPoint(x: 0, y: (frame.size.height / -2) + 101)
        instructionToStart.fontSize = 26
        instructionToStart.text = "Tap Anywhere To Begin"
        instructionToStart.fontColor = SKColor.white
        self.addChild(instructionToStart)
        
        instructionToWait = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        instructionToWait.zPosition = 1
        instructionToWait.position = CGPoint(x: 0, y: (frame.size.height / 2) - 201)
        instructionToWait.fontSize = 28
        instructionToWait.text = "Watch The Pattern"
        instructionToWait.fontColor = SKColor.white
        instructionToWait.isHidden = true
        self.addChild(instructionToWait)
        
        instructionToGo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        instructionToGo.zPosition = 1
        instructionToGo.position = CGPoint(x: 0, y: (frame.size.height / 2) - 201)
        instructionToGo.fontSize = 28
        instructionToGo.text = "Repeat The Pattern"
        instructionToGo.fontColor = SKColor.cyan
        instructionToGo.isHidden = true
        self.addChild(instructionToGo)
        
        instructionToContinue = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        instructionToContinue.zPosition = 1
        instructionToContinue.position = CGPoint(x: 0, y: (frame.size.height / 2) - 201)
        instructionToContinue.fontSize = 28
        instructionToContinue.text = "Press Play To Continue"
        instructionToContinue.fontColor = SKColor.cyan
        instructionToContinue.isHidden = true
        self.addChild(instructionToContinue)
        
        instructionToMenu = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        instructionToMenu.zPosition = 1
        instructionToMenu.position = CGPoint(x: 0, y: (frame.size.height / 2) - 201)
        instructionToMenu.fontSize = 28
        instructionToMenu.text = "Incorrect: Correction Highlighted"
        instructionToMenu.fontColor = SKColor.cyan
        instructionToMenu.isHidden = true
        self.addChild(instructionToMenu)
        
        correct = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        correct.zPosition = 1
        correct.position = CGPoint(x: 0, y: (frame.size.height / 2) - 201)
        correct.fontSize = 28
        correct.text = "Correct"
        correct.fontColor = SKColor.cyan
        correct.isHidden = true
        self.addChild(correct)
        
        touchPad = SKShapeNode(rectOf: CGSize(width: frame.width, height: frame.height),
                               cornerRadius: 0)
        touchPad.name = "touch_pad"
        touchPad.fillColor = SKColor.clear
        self.addChild(touchPad)
        
        
        let cellWidth: CGFloat = frame.size.width / 4
        grid = Grid(blockSize: cellWidth, rows:4, cols:3)
        
        if (grid != nil)  {
            grid.position = CGPoint (x:frame.midX, y:frame.midY)
            grid.isHidden = true
            addChild(grid)
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            //startGame()
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                
                if node.name == "touch_pad" {
                    self.lastScore.isHidden = true
                    startGame()
                }
 
                if node.name == "start_button" {
                    isUserReady = true
                    self.startButton.removeFromParent()
                }
                
                if node.name == "end_button" {
                    toMenu()
                    game.updateScore()
                    self.endButton.removeFromParent()
                    self.grid.box.removeFromParent()
                }
                
            }
        }
    }
    
    private func startGame() {
        //print("start game")
        gameLogo.run(SKAction.move(by: CGVector(dx: -50, dy: 600), duration: 0.5)) {
            self.gameLogo.isHidden = true
        }

        self.instructionToStart.isHidden = true
        
        self.touchPad.isHidden = true
        self.lastScore.isHidden = true
        
        let bottomCorner = CGPoint(x: 0, y: (frame.size.height / -2) + 21)
        bestScore.run(SKAction.move(to: bottomCorner, duration: 0.4))
        bestScore.run(SKAction.move(to: bottomCorner, duration: 0.4)) {
            self.currentScore.setScale(0)
            self.currentScore.isHidden = false
            self.currentScore.run(SKAction.scale(to: 1, duration: 0.4))

        }
        
        userConfirmation()
        self.instructionToContinue.isHidden = false
        

        self.grid.isHidden = false
        
    }
    
    func userConfirmation() {
        //Create start button
        if gameOver == true {
            endButton = SKShapeNode()
            endButton.name = "end_button"
            endButton.isHidden = true
            endButton.zPosition = 1
            endButton.position = CGPoint(x: 0, y: (frame.size.height / -2) + 201)
            endButton.fillColor = SKColor.cyan
            let t = CGPoint(x: -52, y: 52)
            let b = CGPoint(x: -52, y: -52)
            let m = CGPoint(x: 52, y: 0)
            let p = CGMutablePath()
            p.addLine(to: t)
            p.addLines(between: [t, b, m])
            self.endButton.path = p
            self.addChild(endButton)
            
            self.endButton.run(
                SKAction.sequence([
                    SKAction.wait(forDuration: 0.47),
                    SKAction.unhide()
                    ])
            )
            
        }
        else {
            startButton = SKShapeNode()
            startButton.name = "start_button"
            startButton.isHidden = true
            startButton.zPosition = 1
            startButton.position = CGPoint(x: 0, y: (frame.size.height / -2) + 201)
            startButton.fillColor = SKColor.cyan
            let t = CGPoint(x: -52, y: 52)
            let b = CGPoint(x: -52, y: -52)
            let m = CGPoint(x: 52, y: 0)
            let p = CGMutablePath()
            p.addLine(to: t)
            p.addLines(between: [t, b, m])
            self.startButton.path = p
            self.addChild(startButton)
            
            if nextLevel == true {
                self.startButton.isHidden = false
            }
            else {
                self.startButton.run(
                    SKAction.sequence([
                        SKAction.wait(forDuration: 0.27),
                        SKAction.unhide()
                        ])
                )

            }
        }
        
    }
    
    
    func runSimulation() {
        if isUserReady == true {
            let x = (patternLength * (patternLength + 1)) / 2
            if (game.currentScore > x) {
                patternLength += 1
            }
            if count < patternLength {
                self.instructionToContinue.isHidden = true
                self.correct.isHidden = true
                self.instructionToWait.isHidden = false
                self.grid.runSimulation()
                self.count += 1
            }
            else {
                self.instructionToContinue.isHidden = true
                self.correct.isHidden = true
                self.instructionToWait.isHidden = true
                self.instructionToGo.isHidden = false
                self.grid.isSimulationFinished = true
            }
        }
    }
    
    func toMenu() {
        currentScore.run(SKAction.scale(to: 0, duration: 0.4)) {
            self.currentScore.isHidden = true
        }
        self.instructionToContinue.isHidden = true
        self.instructionToMenu.isHidden = true

        
        self.gameLogo.isHidden = false
        self.grid.isHidden = true
        self.gameLogo.run(SKAction.move(to: CGPoint(x: 0, y: (self.frame.size.height / 2) - 201), duration: 0.5)) {
            self.instructionToStart.isHidden = false
            self.instructionToStart.run(SKAction.scale(to: 1, duration: 0.3))
            self.touchPad.isHidden = false
            
            self.bestScore.run(SKAction.move(to: CGPoint(x: 0, y: self.gameLogo.position.y - 71), duration: 0.3))
        }
        
        self.lastScore.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 0.37),
                SKAction.unhide()
                ])
        )
    }
    
    func checkForScore() -> Bool{
        if grid.isSimulationFinished == true && grid.guessR.isEmpty == false && grid.guessC.isEmpty == false {
            if grid.solutionR[0] == grid.guessR[0] && grid.solutionC[0] == grid.guessC[0] {
                self.grid.solutionR.remove(at: 0)
                self.grid.solutionC.remove(at: 0)
                self.grid.guessR.remove(at: 0)
                self.grid.guessC.remove(at: 0)
                
                if grid.solutionR.isEmpty == true && grid.solutionC.isEmpty == true {
                    self.nextLevel = true
                    self.grid.guessR.removeAll()
                    self.grid.guessC.removeAll()
                }
                return true
            }
            else {
                self.correctRow = grid.solutionR[0]
                self.correctCol = grid.solutionC[0]
                
                self.grid.solutionR.removeAll()
                self.grid.solutionC.removeAll()
                self.grid.guessR.removeAll()
                self.grid.guessC.removeAll()
                
                self.gameOver = true
                return true
            }
        }
        return false
        
    }
    
}
