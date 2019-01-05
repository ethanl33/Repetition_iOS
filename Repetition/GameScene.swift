//
//  GameScene.swift
//  Repetition
//
//  Created by Ethan Lee on 8/22/18.
//  Copyright © 2018 Ethan Lee. All rights reserved.
//

import SpriteKit
import GameplayKit

//fix code so when insanity is on, it stays on after coming from shop scene
class GameScene: SKScene {
    
    
    var beginGame: SKShapeNode!
    var startLevel: SKShapeNode!
    var startButton: SKShapeNode!
    var endButton: SKShapeNode!
    var touchToStart: SKShapeNode!

    var volumeButton: SKSpriteNode!
    var muteButton: SKSpriteNode!
    var insanityOn: SKSpriteNode!
    var insanityOff: SKSpriteNode!
    var shopButton: SKSpriteNode!
    var carbon: SKSpriteNode!
    var powerUp: SKSpriteNode!

    var isInsane: Bool = UserDefaults.standard.bool(forKey: "isInsane")
    var isMute: Bool = UserDefaults.standard.bool(forKey: "isMute")
    
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
    var carbonLabel: SKLabelNode!
    var insanityTeaser: SKLabelNode!
    
    var game: GameManager!
    
    var correctRow: Int!
    var correctCol: Int!

    var grid: Grid!
    var isUserReady = false
    var nextLevel = false
    var gameOver = false
    var count: Int = 0
    var patternLength: Int = 1
    var carbonPoint: Int = UserDefaults.standard.integer(forKey: "carbonPoint")

    
    override func didMove(to view: SKView) {
        initializeMenu()
        game = GameManager(scene: self)
        initializeGameView()
    }
    
    private func initializeGameView() {
        
        var posY: CGFloat = 0.0
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1136:
                    //print("iPhone 5 or 5S or 5C")
                    posY = 61.0
                case 1334:
                    //print("iPhone 6/6S/7/8")
                    posY = 61.0
                case 1920, 2208:
                    //print("iPhone 6+/6S+/7+/8+")
                    posY = 61.0
                case 2436:
                    //print("iPhone X, Xs")
                    posY = 71.0
                case 2688:
                    //print("iPhone Xs Max")
                    posY = 71.0
                case 1792:
                    //print("iPhone Xr")
                    posY = 71.0
                default:
                    //print("unknown")
                    posY = 71.0
            }
        }
        currentScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        currentScore.zPosition = 1
        currentScore.position = CGPoint(x: 0, y: (frame.size.height / -2) + posY)
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
        if isInsane {
            gameLogo.fontColor = SKColor.red
        }
        else {
            gameLogo.fontColor = SKColor.cyan
        }
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
        
        
        touchToStart = SKShapeNode()
        touchToStart.isHidden = false
        touchToStart.zPosition = 1
        touchToStart.position = CGPoint(x: 0, y: (frame.size.height / -2) + 201)
        touchToStart.fillColor = SKColor.clear
        touchToStart.strokeColor = SKColor.clear
        let topLeft = CGPoint(x: -(frame.size.width / 2), y: (frame.size.height / 1))
        let bottomLeft = CGPoint(x: -(frame.size.width / 2), y: -52)
        let topRight = CGPoint(x: (frame.size.width / 2), y: (frame.size.height / 1))
        let bottomRight = CGPoint(x: (frame.size.width / 2), y: -52)
        let position = CGMutablePath()
        position.addLine(to: topLeft)
        position.addLines(between: [topLeft, topRight, bottomRight, bottomLeft])
        self.touchToStart.path = position
        touchToStart.name = "touch_to_start"
        self.addChild(touchToStart)
        
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
        
        insanityTeaser = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        insanityTeaser.zPosition = 1
        insanityTeaser.alpha = 0.0
        insanityTeaser.position = CGPoint(x: 0, y: -(frame.size.height / 4))
        insanityTeaser.fontSize = 28
        insanityTeaser.text = "Insanity Mode Coming Soon..."
        insanityTeaser.fontColor = SKColor.red
        insanityTeaser.isHidden = false
        self.addChild(insanityTeaser)
 
        var posX: CGFloat = 0.0
        var squareX: CGFloat = 0.0
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1136:
                    //print("iPhone 5 or 5S or 5C")
                    posX = 120.0
                    squareX = 155.0
                case 1334:
                    //print("iPhone 6/6S/7/8")
                    posX = 120.0
                    squareX = 155.0
                case 1920, 2208:
                    //print("iPhone 6+/6S+/7+/8+")
                    posX = 120.0
                    squareX = 155.0
                case 2436:
                    //print("iPhone X, Xs")
                    posX = 180.0
                    squareX = 195.0
                case 2688:
                    //print("iPhone Xs Max")
                    posX = 180.0
                    squareX = 195.0
                case 1792:
                    //print("iPhone Xr")
                    posX = 180.0
                    squareX = 195.0
                default:
                    //print("unknown")
                    posX = 180.0
                    squareX = 195.0
            }
        }
        
        let imageTexture1 = SKTexture(imageNamed: "volume")
        volumeButton = SKSpriteNode(texture: imageTexture1)
        self.isUserInteractionEnabled = true
        volumeButton.name = "volume_button"
        if UserDefaults.standard.bool(forKey: "isMute") {
            volumeButton.isHidden = true
        }
        else {
            volumeButton.isHidden = false
        }
        volumeButton.zPosition = 1
        volumeButton.position = CGPoint(x: -(frame.size.width / 2) + posX, y: -(frame.size.height / 2) + 101)
        //volumeButton.color = UIColor.white
        //volumeButton.colorBlendFactor = 1.0
        volumeButton.setScale(0.704)
        self.addChild(volumeButton)
        
        
        let imageTexture2 = SKTexture(imageNamed: "mute")
        muteButton = SKSpriteNode(texture: imageTexture2)
        self.isUserInteractionEnabled = true
        muteButton.name = "mute_button"
        if UserDefaults.standard.bool(forKey: "isMute") {
            muteButton.isHidden = false
        }
        else {
            muteButton.isHidden = true
        }
        muteButton.zPosition = 1
        muteButton.position = CGPoint(x: -(frame.size.width / 2) + posX, y: -(frame.size.height / 2) + 101)
        //muteButton.color = UIColor.cyan
        //muteButton.colorBlendFactor = 1.0
        muteButton.setScale(0.704)
        self.addChild(muteButton)
        
        if isMute {
            GameViewController.sharedHelper.muteBackgroundMusic()
        }
        else {
            if !GameViewController.sharedHelper.musicIsPlaying() {
                GameViewController.sharedHelper.startBackgroundMusic()
            }
        }
        
        let imageTexture3 = SKTexture(imageNamed: "insanity_red")
        insanityOn = SKSpriteNode(texture: imageTexture3)
        self.isUserInteractionEnabled = true
        insanityOn.name = "insanity_on"
        if UserDefaults.standard.bool(forKey: "isInsane") {
            insanityOn.isHidden = false
        }
        else {
            insanityOn.isHidden = true
        }
        insanityOn.zPosition = 1
        insanityOn.position = CGPoint(x: (frame.size.width / 2) - posX, y: -(frame.size.height / 2) + 101)
        //insanityOn.color = UIColor.cyan
        //insanityOn.colorBlendFactor = 1.0
        insanityOn.setScale(0.704)
        self.addChild(insanityOn)
        
        let imageTexture4 = SKTexture(imageNamed: "insanity")
        insanityOff = SKSpriteNode(texture: imageTexture4)
        self.isUserInteractionEnabled = true
        insanityOff.name = "insanity_off"
        if UserDefaults.standard.bool(forKey: "isInsane") {
            insanityOff.isHidden = true
        }
        else {
            insanityOff.isHidden = false
        }
        insanityOff.zPosition = 1
        insanityOff.position = CGPoint(x: (frame.size.width / 2) - posX, y: -(frame.size.height / 2) + 101)
        //insanityOff.color = UIColor.cyan
        //insanityOff.colorBlendFactor = 1.0
        insanityOff.setScale(0.704)
        self.addChild(insanityOff)
        
        let imageTexture5 = SKTexture(imageNamed: "shop")
        shopButton = SKSpriteNode(texture: imageTexture5)
        self.isUserInteractionEnabled = true
        shopButton.name = "shop_button"
        shopButton.isHidden = false
        shopButton.zPosition = 1
        shopButton.position = CGPoint(x: 0, y: -(frame.size.height / 2) + 101)
        shopButton.setScale(0.704)
        self.addChild(shopButton)
        
        carbonLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        carbonLabel.position = CGPoint(x: (frame.size.width / 2) - squareX - 10, y: (frame.size.height / 2) - 115)
        carbonLabel.fontSize = 41
        carbonLabel.isHidden = false
        carbonLabel.text = "\(UserDefaults.standard.integer(forKey: "carbonPoint"))"
        carbonLabel.fontColor = SKColor.white
        self.addChild(carbonLabel)
        
        let imageTexture6 = SKTexture(imageNamed: "diamond")
        carbon = SKSpriteNode(texture: imageTexture6)
        self.isUserInteractionEnabled = true
        carbon.isHidden = false
        carbon.zPosition = 1
        carbon.position = CGPoint(x: carbonLabel.frame.maxX + 37, y: (frame.size.height / 2) - 101)
        self.addChild(carbon)
        
        instructionToStart = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        instructionToStart.zPosition = 1
        instructionToStart.position = CGPoint(x: 0, y: shopButton.position.y + 101)
        instructionToStart.fontSize = 26
        instructionToStart.text = "Tap Above To Start"
        instructionToStart.fontColor = SKColor.white
        self.addChild(instructionToStart)
        
        
        let cellWidth: CGFloat = frame.size.width / 4
        grid = Grid(blockSize: cellWidth, rows:4, cols:3)
        
        if (grid != nil)  {
            grid.position = CGPoint (x:frame.midX, y:frame.midY)
            grid.isHidden = true
            addChild(grid)
            
        }
        
        let selectedPowerUp: Int = UserDefaults.standard.integer(forKey: "selectedPowerUp")
        var i: SKTexture
        if selectedPowerUp != 0 {
            if selectedPowerUp == 1 {
                i = SKTexture(imageNamed: "double")
                powerUp = SKSpriteNode(texture: i)
            }
            else if selectedPowerUp == 2 {
                i = SKTexture(imageNamed: "redo")
                powerUp = SKSpriteNode(texture: i)
            }
            else if selectedPowerUp == 3 {
                i = SKTexture(imageNamed: "magnifying_glass")
                powerUp = SKSpriteNode(texture: i)
            }
            else if selectedPowerUp == 4 {
                i = SKTexture(imageNamed: "last_resort")
                powerUp = SKSpriteNode(texture: i)
            }
            powerUp.position = CGPoint(x: volumeButton.position.x - 25, y: carbon.position.y)
            powerUp.isHidden = false
            self.addChild(powerUp)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            //startGame()
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "mute_button" {
                    volumeButton.isHidden = false
                    muteButton.isHidden = true
                    isMute = false
                    
                    UserDefaults.standard.set(isMute, forKey: "isMute")

                    GameViewController.sharedHelper.startBackgroundMusic()
                }
                
                if node.name == "volume_button" {
                    volumeButton.isHidden = true
                    muteButton.isHidden = false
                    isMute = true
                    
                    UserDefaults.standard.set(isMute, forKey: "isMute")

                    GameViewController.sharedHelper.muteBackgroundMusic()
                }
                
                if node.name == "insanity_on" {
                    insanityOff.isHidden = false
                    insanityOn.isHidden = true
                    isInsane = false

                    UserDefaults.standard.set(isInsane, forKey: "isInsane")

                    gameLogo.fontColor = SKColor.cyan
                    //beginGame.fillColor = SKColor.cyan
                    self.grid.isInsane = false
                }
                
                if node.name == "insanity_off" {
                    insanityOff.isHidden = true
                    insanityOn.isHidden = false
                    isInsane = true

                    UserDefaults.standard.set(isInsane, forKey: "isInsane")
                    
                    gameLogo.fontColor = SKColor.red
                    //beginGame.fillColor = SKColor.red
                    self.grid.isInsane = true
                    
                    self.insanityTeaser.run(
                        SKAction.sequence([
                            SKAction.fadeIn(withDuration: 0.5),
                            SKAction.wait(forDuration: 2.5),
                            SKAction.fadeOut(withDuration: 0.5)
                            ])
                    )
                }
                
                if node.name == "touch_to_start" {
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
                
                if node.name == "shop_button" {
                    let scene = ShopScene(fileNamed: "ShopScene")!
                    let transition = SKTransition.moveIn(with: .right, duration: 0.3)
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene, transition: transition)
                    scene.backgroundColor = SKColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
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
        self.insanityOff.isHidden = true
        self.insanityOn.isHidden = true
        
        self.shopButton.isHidden = true
        
        self.muteButton.isHidden = true
        self.volumeButton.isHidden = true

        //self.beginGame.isHidden = true
        self.touchToStart.isHidden = true
        self.lastScore.isHidden = true
        
        var posY: CGFloat = 0.0
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1136:
                    //print("iPhone 5 or 5S or 5C")
                    posY = 21.0
                case 1334:
                    //print("iPhone 6/6S/7/8")
                    posY = 21.0
                case 1920, 2208:
                    //print("iPhone 6+/6S+/7+/8+")
                    posY = 21.0
                case 2436:
                    //print("iPhone X, Xs")
                    posY = 33.0
                case 2688:
                    //print("iPhone Xs Max")
                    posY = 33.0
                case 1792:
                    //print("iPhone Xr")
                    posY = 33.0
                default:
                    //print("unknown")
                    posY = 33.0
            }
        }
        
        let bottomCorner = CGPoint(x: 0, y: (frame.size.height / -2) + posY)
        bestScore.run(SKAction.move(to: bottomCorner, duration: 0.4))
        bestScore.run(SKAction.move(to: bottomCorner, duration: 0.4)) {
            self.currentScore.setScale(0)
            self.currentScore.isHidden = false
            self.currentScore.run(SKAction.scale(to: 1, duration: 0.4))

        }
        
        userConfirmation()
        if self.isInsane {
            self.instructionToContinue.fontColor = SKColor.red
        }
        else {
            self.instructionToContinue.fontColor = SKColor.cyan
        }
        self.instructionToContinue.isHidden = false
        

        self.grid.isHidden = false
        
    }
    
    func userConfirmation() {
        //Create start button
        if gameOver == true {
            endButton = SKShapeNode()
            endButton.name = "end_button"
            endButton.strokeColor = SKColor.clear
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
            
            if isInsane {
                endButton.fillColor = SKColor.red
            }
            else {
                endButton.fillColor = SKColor.cyan
            }
            
        }
        else {
            startButton = SKShapeNode()
            startButton.name = "start_button"
            startButton.strokeColor = SKColor.clear
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
            
            if isInsane {
                startButton.fillColor = SKColor.red
            }
            else {
                startButton.fillColor = SKColor.cyan
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
                
                if self.isInsane {
                    self.instructionToWait.fontColor = SKColor.red
                }
                else {
                    self.instructionToWait.fontColor = SKColor.cyan
                }
                self.instructionToWait.isHidden = false
                
                self.grid.runSimulation()
                self.count += 1
            }
            else {
                self.instructionToContinue.isHidden = true
                self.correct.isHidden = true
                self.instructionToWait.isHidden = true
                
                if self.isInsane {
                    self.instructionToGo.fontColor = SKColor.red
                }
                else {
                    self.instructionToGo.fontColor = SKColor.cyan
                }
                self.instructionToGo.isHidden = false
                
                self.grid.isSimulationFinished = true
            }
        }
    }
    
    func toMenu() {
        currentScore.run(SKAction.scale(to: 0, duration: 0.4)) {
            self.currentScore.isHidden = true
        }
        //self.instructionToContinue.isHidden = true
        self.instructionToMenu.isHidden = true

        if isInsane {
            self.insanityOn.isHidden = false
        }
        else {
            self.insanityOff.isHidden = false
        }
        
        if isMute {
            self.muteButton.isHidden = false
        }
        else {
            self.volumeButton.isHidden = false
        }
        
        self.shopButton.isHidden = false
        
        self.gameLogo.isHidden = false
        self.grid.isHidden = true
        self.gameLogo.run(SKAction.move(to: CGPoint(x: 0, y: (self.frame.size.height / 2) - 201), duration: 0.5)) {
            self.instructionToStart.isHidden = false
            self.instructionToStart.run(SKAction.scale(to: 1, duration: 0.3))
            //self.beginGame.isHidden = false
            self.touchToStart.isHidden = false
            
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
                if grid.carbonR.isEmpty == false && grid.carbonC.isEmpty == false {
                    if grid.carbonR[0] == grid.guessR[0] && grid.carbonC[0] == grid.guessC[0] {
                        self.grid.carbonR.remove(at: 0)
                        self.grid.carbonC.remove(at: 0)
                        carbonPoint += 1
                    }
                }
                self.grid.solutionR.remove(at: 0)
                self.grid.solutionC.remove(at: 0)
                self.grid.guessR.remove(at: 0)
                self.grid.guessC.remove(at: 0)
                
                if grid.solutionR.isEmpty == true && grid.solutionC.isEmpty == true {
                    self.nextLevel = true
                    self.grid.guessR.removeAll()
                    self.grid.guessC.removeAll()
                    self.grid.carbonR.removeAll()
                    self.grid.carbonC.removeAll()
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
                self.grid.carbonR.removeAll()
                self.grid.carbonC.removeAll()
                
                self.gameOver = true
                return true
            }
        }
        return false
        
    }
    
}
