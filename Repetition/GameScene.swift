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
    
    var gameLogo: SKLabelNode!
    var bestScore: SKLabelNode!
    //var playButton: SKShapeNode!
    var startLevel: SKShapeNode!
    var startButton: SKShapeNode!
    var instructions: SKLabelNode!
    var touchPad: SKShapeNode!
    
    var game: GameManager!
    
    var currentScore: SKLabelNode!
    var gameBG: SKShapeNode!
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []

    var grid: Grid!
    var isUserReady = false
    var nextLevel = false
    var gameOver = false
    var count: Int = 0

    
    override func didMove(to view: SKView) {
        initializeMenu()
        game = GameManager(scene: self)
        initializeGameView()
    }
    
    private func initializeGameView() {
        //4
        currentScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        currentScore.zPosition = 1
        currentScore.position = CGPoint(x: 0, y: (frame.size.height / -2) + 60)
        currentScore.fontSize = 40
        currentScore.isHidden = true
        currentScore.text = "Score: 0"
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
        gameLogo.position = CGPoint(x: 0, y: (frame.size.height / 2) - 200)
        gameLogo.fontSize = 60
        gameLogo.text = "Repetition"
        //gameLogo.fontColor = SKColor(red: 36/255, green: 93/255, blue: 104/255, alpha: 1)
        gameLogo.fontColor = SKColor(red: 209/255, green: 174/255, blue: 172/255, alpha: 1)
        self.addChild(gameLogo)
        //Create best score label
        bestScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0, y: gameLogo.position.y - 50)
        bestScore.fontSize = 40
        bestScore.text = "Best Score: 0"
        bestScore.text = "Best Score: \(UserDefaults.standard.integer(forKey: "bestScore"))"
        bestScore.fontColor = SKColor.white
        self.addChild(bestScore)
        //Create game title
        instructions = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        instructions.zPosition = 1
        instructions.position = CGPoint(x: 0, y: (frame.size.height / -2) + 100)
        instructions.fontSize = 25
        instructions.text = "Tap Anywhere To Begin"
        instructions.fontColor = SKColor.white
        self.addChild(instructions)
        
        touchPad = SKShapeNode(rectOf: CGSize(width: frame.width, height: frame.height),
                               cornerRadius: 0)
        touchPad.name = "touch_pad"
        touchPad.fillColor = SKColor.black
        self.addChild(touchPad)
        /*
        //Create play button
        playButton = SKShapeNode()
        playButton.name = "play_button"
        playButton.zPosition = 1
        playButton.position = CGPoint(x: 0, y: (frame.size.height / -2) + 200)
        playButton.fillColor = SKColor.cyan
        let topCorner = CGPoint(x: -50, y: 50)
        let bottomCorner = CGPoint(x: -50, y: -50)
        let middle = CGPoint(x: 50, y: 0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])
        playButton.path = path
        self.addChild(playButton)
 */
        
        
        
        let cellWidth: CGFloat = frame.size.width / 4
        grid = Grid(blockSize: cellWidth, rows:4, cols:3)
        
        if (grid != nil)  {
            grid.position = CGPoint (x:frame.midX, y:frame.midY)
            grid.isHidden = true
            addChild(grid)
            /*
             let gamePiece = SKSpriteNode(imageNamed: "Spaceship1")
             gamePiece.setScale(0.0625)
             gamePiece.position = grid.gridPosition(row: 1, col: 0)
             grid.addChild(gamePiece)
             */
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            //startGame()
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                
                if node.name == "touch_pad" {
                    startGame()
                }
 
                if node.name == "start_button" {
                    isUserReady = true
                    self.startButton.removeFromParent()
                }
            }
        }
    }
    
    private func startGame() {
        print("start game")
        //1
        gameLogo.run(SKAction.move(by: CGVector(dx: -50, dy: 600), duration: 0.5)) {
            self.gameLogo.isHidden = true
        }
        //2
        /*
        playButton.run(SKAction.scale(to: 0, duration: 0.3)) {
            self.playButton.isHidden = true
        }
 */
        instructions.run(SKAction.scale(to: 0, duration: 0.3)) {
            self.instructions.isHidden = true
        }
        
        self.touchPad.isHidden = true
        
        //3
        let bottomCorner = CGPoint(x: 0, y: (frame.size.height / -2) + 20)
        bestScore.run(SKAction.move(to: bottomCorner, duration: 0.4))
        bestScore.run(SKAction.move(to: bottomCorner, duration: 0.4)) {
            //self.gameBG.setScale(0)
            self.currentScore.setScale(0)
            //self.gameBG.isHidden = false
            self.currentScore.isHidden = false
            //self.gameBG.run(SKAction.scale(to: 1, duration: 0.4))
            self.currentScore.run(SKAction.scale(to: 1, duration: 0.4))
            
            //self.game.initGame()
        }
        
        userConfirmation()
        
        

        grid.isHidden = false
        
    }
    
    func userConfirmation() {
        //Create start button
        
        startButton = SKShapeNode()
        startButton.name = "start_button"
        startButton.zPosition = 1
        startButton.position = CGPoint(x: frame.midX, y: frame.midY)
        startButton.fillColor = SKColor.cyan
        let t = CGPoint(x: -50, y: 50)
        let b = CGPoint(x: -50, y: -50)
        let m = CGPoint(x: 50, y: 0)
        let path = CGMutablePath()
        path.addLine(to: t)
        path.addLines(between: [t, b, m])
        startButton.path = path
        self.addChild(startButton)
    }
    
    
    func runSimulation() {
        if isUserReady == true {
            if count < game.currentScore {
                print("test")
                grid.runSimulation()
                count += 1
            }
            else {
                grid.isSimulationFinished = true
            }
        }
    }
    
    func checkForScore() -> Bool{
        if grid.isSimulationFinished == true && grid.guessR.isEmpty == false && grid.guessC.isEmpty == false {
            if grid.solutionR[0] == grid.guessR[0] && grid.solutionC[0] == grid.guessC[0] {
                grid.solutionR.remove(at: 0)
                grid.solutionC.remove(at: 0)
                grid.guessR.remove(at: 0)
                grid.guessC.remove(at: 0)
                
                if grid.solutionR.isEmpty == true && grid.solutionC.isEmpty == true {
                    nextLevel = true
                }
                return true
            }
            else {
                grid.solutionR.removeAll()
                grid.solutionC.removeAll()
                grid.guessR.removeAll()
                grid.guessC.removeAll()
                gameOver = true
                return true
            }
        }
        return false
        
    }
    
}
