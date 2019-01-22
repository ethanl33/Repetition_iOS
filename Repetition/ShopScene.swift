//
//  ShopScene.swift
//  Repetition
//
//  Created by Ethan Lee on 9/30/18.
//  Copyright © 2018 Ethan Lee. All rights reserved.
//

import SpriteKit
import GameplayKit

class ShopScene: SKScene {
    

    var item1: SKShapeNode!
    var item2: SKShapeNode!
    var item3: SKShapeNode!
    var item4: SKShapeNode!
    var item5: SKShapeNode!
    var item6: SKShapeNode!
    var item7: SKShapeNode!
    var item8: SKShapeNode!
    var item9: SKShapeNode!
    var item10: SKShapeNode!
    
    var backButton: SKSpriteNode!
    var touchBackButton: SKShapeNode!
    
    var shopLogo: SKLabelNode!
    
    var item1Label: SKLabelNode!
    var item2Label: SKLabelNode!
    var item3Label: SKLabelNode!
    var item4Label: SKLabelNode!
    var item5Label: SKLabelNode!
    var item6Label: SKLabelNode!
    var item7Label: SKLabelNode!
    var item8Label: SKLabelNode!
    var item9Label: SKLabelNode!
    var item10Label: SKLabelNode!
    
    var item1Picture: SKSpriteNode!
    var item2Picture: SKSpriteNode!
    var item3Picture: SKSpriteNode!
    var item4Picture: SKSpriteNode!
    var item5Picture: SKSpriteNode!
    var item6Picture: SKSpriteNode!
    var item7Picture: SKSpriteNode!
    var item8Picture: SKSpriteNode!
    var item9Picture: SKSpriteNode!
    var item10Picture: SKSpriteNode!
    
    var item1Carbon: SKSpriteNode!
    var item2Carbon: SKSpriteNode!
    var item3Carbon: SKSpriteNode!
    var item4Carbon: SKSpriteNode!
    var item5Carbon: SKSpriteNode!
    var item6Carbon: SKSpriteNode!
    var item7Carbon: SKSpriteNode!
    var item8Carbon: SKSpriteNode!
    var item9Carbon: SKSpriteNode!
    var item10Carbon: SKSpriteNode!

    
    var carbonLabel: SKLabelNode!
    var carbon: SKSpriteNode!
    var carbonPoint: Int = UserDefaults.standard.integer(forKey: "carbonPoint")


    var info: SKLabelNode!
    var instruction: SKLabelNode!
    var descrip: SKLabelNode!
    
    var isInsane: Bool = UserDefaults.standard.bool(forKey: "isInsane")
    var isMute: Bool = UserDefaults.standard.bool(forKey: "isMute")
    
    var selectedPowerUp: Int = UserDefaults.standard.integer(forKey: "selectedPowerUp")

    
    override func didMove(to view: SKView) {
        initializeShop()
        updateShop()
        scene?.scaleMode = .aspectFill
        
        /*
        UserDefaults.standard.set(0, forKey: "selectedPowerUp")
        UserDefaults.standard.set(false, forKey: "item1isUnlocked")
        UserDefaults.standard.set(false, forKey: "item2isUnlocked")
        UserDefaults.standard.set(false, forKey: "item3isUnlocked")
        UserDefaults.standard.set(false, forKey: "item4isUnlocked")
        UserDefaults.standard.set(1000, forKey: "carbonPoint")
 */

    }
    
    override func update(_ currentTime: TimeInterval) {
        carbon.position = CGPoint(x: carbonLabel.frame.maxX + 37, y: (frame.size.height / 2) - 101)
        if info.text != "More Carbon Points Needed" {
            if UserDefaults.standard.integer(forKey: "selectedPowerUp") == 1 || UserDefaults.standard.integer(forKey: "selectedPowerUp") == 2 || UserDefaults.standard.integer(forKey: "selectedPowerUp") == 4 {
                instruction.text = "(Automatic Activation)"
                instruction.isHidden = false
                info.alpha = 1.0
            }
            else if UserDefaults.standard.integer(forKey: "selectedPowerUp") == 3 {
                instruction.text = "(Tap Icon In-Game To Activate)"
                instruction.isHidden = false
                info.alpha = 1.0
            }
            else {
                instruction.isHidden = true
            }
        }
        else {
            instruction.isHidden = true
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            //startGame()
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                
                if node.name == "back_button" {
                    let scene = GameScene(fileNamed: "GameScene")!
                    let transition = SKTransition.moveIn(with: .left, duration: 0.3)
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene, transition: transition)
                    //print("test")
                }
                
                
                if node.name == "item1" {
                    info.removeAllActions()
                    if !UserDefaults.standard.bool(forKey: "item1isUnlocked") {
                        if carbonPoint >= 500 {
                            item1Picture.isHidden = false
                            item1Label.isHidden = true
                            item1Carbon.isHidden = true
                            item1.strokeColor = SKColor.cyan
                            info.text = "Double Carbon Points"
                            UserDefaults.standard.set(1, forKey: "selectedPowerUp")
                            UserDefaults.standard.set(true, forKey: "item1isUnlocked")
                            deselectOtherBoxes(num: 1)
                            carbonPoint -= 500
                            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "carbonPoint") - 500, forKey: "carbonPoint")
                            carbonLabel.text = "\(UserDefaults.standard.integer(forKey: "carbonPoint"))"
                        }
                        else {
                            info.text = "More Carbon Points Needed"
                        }
                    }
                    else {
                        item1.strokeColor = SKColor.cyan
                        info.text = "Double Carbon Points"
                        UserDefaults.standard.set(1, forKey: "selectedPowerUp")
                        deselectOtherBoxes(num: 1)
                    }
                    self.info.run(
                        SKAction.sequence([
                            SKAction.fadeAlpha(to: 1.0, duration: 0.5),
                            //SKAction.wait(forDuration: 2.5),
                            //SKAction.fadeOut(withDuration: 0.5)
                            ])
                    )
                }
    
                
                
                if node.name == "item2" {
                    info.removeAllActions()
                    if !UserDefaults.standard.bool(forKey: "item2isUnlocked") {
                        if carbonPoint >= 500 {
                            item2Picture.isHidden = false
                            item2Label.isHidden = true
                            item2Carbon.isHidden = true
                            item2.strokeColor = SKColor.cyan
                            info.text = "Head Start"
                            UserDefaults.standard.set(2, forKey: "selectedPowerUp")
                            UserDefaults.standard.set(true, forKey: "item2isUnlocked")
                            deselectOtherBoxes(num: 2)
                            carbonPoint -= 500
                            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "carbonPoint") - 500, forKey: "carbonPoint")
                            carbonLabel.text = "\(UserDefaults.standard.integer(forKey: "carbonPoint"))"
                        }
                        else {
                            info.text = "More Carbon Points Needed"
                        }
                    }
                    else {
                        item2.strokeColor = SKColor.cyan
                        info.text = "Head Start"
                        UserDefaults.standard.set(2, forKey: "selectedPowerUp")
                        deselectOtherBoxes(num: 2)
                    }
                    self.info.run(
                        SKAction.sequence([
                            SKAction.fadeAlpha(to: 1.0, duration: 0.5),
                            //SKAction.wait(forDuration: 2.5),
                            //SKAction.fadeOut(withDuration: 0.5)
                            ])
                    )
                }
                
                
                
                if node.name == "item3" {
                    info.removeAllActions()
                    if !UserDefaults.standard.bool(forKey: "item3isUnlocked") {
                        if carbonPoint >= 500 {
                            item3Picture.isHidden = false
                            item3Label.isHidden = true
                            item3Carbon.isHidden = true
                            item3.strokeColor = SKColor.cyan
                            info.text = "Skip A Level"
                            UserDefaults.standard.set(3, forKey: "selectedPowerUp")
                            UserDefaults.standard.set(true, forKey: "item3isUnlocked")
                            deselectOtherBoxes(num: 3)
                            carbonPoint -= 500
                            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "carbonPoint") - 500, forKey: "carbonPoint")
                            carbonLabel.text = "\(UserDefaults.standard.integer(forKey: "carbonPoint"))"
                        }
                        else {
                            info.text = "More Carbon Points Needed"
                        }
                    }
                    else {
                        item3.strokeColor = SKColor.cyan
                        info.text = "Skip A Level"
                        UserDefaults.standard.set(3, forKey: "selectedPowerUp")
                        deselectOtherBoxes(num: 3)
                    }
                    
                    self.info.run(
                        SKAction.sequence([
                            SKAction.fadeAlpha(to: 1.0, duration: 0.5),
                            //SKAction.wait(forDuration: 2.5),
                            //SKAction.fadeOut(withDuration: 0.5)
                            ])
                    )
                }
                
                
                if node.name == "item4" {
                    info.removeAllActions()
                    if !UserDefaults.standard.bool(forKey: "item4isUnlocked") {
                        if carbonPoint >= 500 {
                            item4Picture.isHidden = false
                            item4Label.isHidden = true
                            item4Carbon.isHidden = true
                            item4.strokeColor = SKColor.cyan
                            info.text = "Postmortem Boost"
                            UserDefaults.standard.set(4, forKey: "selectedPowerUp")
                            UserDefaults.standard.set(true, forKey: "item4isUnlocked")
                            deselectOtherBoxes(num: 4)
                            carbonPoint -= 500
                            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "carbonPoint") - 500, forKey: "carbonPoint")
                            carbonLabel.text = "\(UserDefaults.standard.integer(forKey: "carbonPoint"))"
                        }
                        else {
                            info.text = "More Carbon Points Needed"
                        }
                    }
                    else {
                        item4.strokeColor = SKColor.cyan
                        info.text = "Postmortem Boost"
                        UserDefaults.standard.set(4, forKey: "selectedPowerUp")
                        deselectOtherBoxes(num: 4)
                    }
                    self.info.run(
                        SKAction.sequence([
                            SKAction.fadeAlpha(to: 1.0, duration: 0.5),
                            //SKAction.wait(forDuration: 2.5),
                            //SKAction.fadeOut(withDuration: 0.5)
                            ])
                    )
                }
                
                /*
                if node.name == "item5" {
                    info.removeAllActions()
                    if !UserDefaults.standard.bool(forKey: "item5isUnlocked") {
                        if carbonPoint > 1000 {
                            item5Picture.isHidden = false
                            item5Label.isHidden = true
                            item5Carbon.isHidden = true
                            item5.strokeColor = SKColor.cyan
                            info.text = "???"
                            UserDefaults.standard.set(5, forKey: "selectedPowerUp")
                            UserDefaults.standard.set(true, forKey: "item5isUnlocked")
                            deselectOtherBoxes(num: 5)
                            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "carbonPoint") - 1000, forKey: "carbonPoint")
                            carbonLabel.text = "\(UserDefaults.standard.integer(forKey: "carbonPoint"))"
                        }
                        else {
                            info.text = "More Carbon Points Needed"
                        }
                    }
                    else {
                        item5.strokeColor = SKColor.cyan
                        info.text = "???"
                        UserDefaults.standard.set(5, forKey: "selectedPowerUp")
                        deselectOtherBoxes(num: 5)
                    }
                    self.info.run(
                        SKAction.sequence([
                            SKAction.fadeAlpha(to: 1.0, duration: 0.5),
                            SKAction.wait(forDuration: 2.5),
                            SKAction.fadeOut(withDuration: 0.5)
                            ])
                    )
                }
                
                
                if node.name == "item6" {
                    info.removeAllActions()
                    if !UserDefaults.standard.bool(forKey: "item6isUnlocked") {
                        if carbonPoint > 1000 {
                            item6Picture.isHidden = false
                            item6Label.isHidden = true
                            item6Carbon.isHidden = true
                            item6.strokeColor = SKColor.cyan
                            info.text = "???"
                            UserDefaults.standard.set(6, forKey: "selectedPowerUp")
                            UserDefaults.standard.set(true, forKey: "item6isUnlocked")
                            deselectOtherBoxes(num: 6)
                            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "carbonPoint") - 1000, forKey: "carbonPoint")
                            carbonLabel.text = "\(UserDefaults.standard.integer(forKey: "carbonPoint"))"
                        }
                        else {
                            info.text = "More Carbon Points Needed"
                        }
                    }
                    else {
                        item6.strokeColor = SKColor.cyan
                        info.text = "???"
                        UserDefaults.standard.set(6, forKey: "selectedPowerUp")
                        deselectOtherBoxes(num: 6)
                    }
                    self.info.run(
                        SKAction.sequence([
                            SKAction.fadeAlpha(to: 1.0, duration: 0.5),
                            SKAction.wait(forDuration: 2.5),
                            SKAction.fadeOut(withDuration: 0.5)
                            ])
                    )
                }
                
                if node.name == "item7" {
                    info.removeAllActions()
                    if !UserDefaults.standard.bool(forKey: "item7isUnlocked") {
                        if carbonPoint > 1000 {
                            item7Picture.isHidden = false
                            item7Label.isHidden = true
                            item7Carbon.isHidden = true
                            item7.strokeColor = SKColor.cyan
                            info.text = "???"
                            UserDefaults.standard.set(7, forKey: "selectedPowerUp")
                            UserDefaults.standard.set(true, forKey: "item7isUnlocked")
                            deselectOtherBoxes(num: 7)
                            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "carbonPoint") - 1000, forKey: "carbonPoint")
                            carbonLabel.text = "\(UserDefaults.standard.integer(forKey: "carbonPoint"))"
                        }
                        else {
                            info.text = "More Carbon Points Needed"
                        }
                    }
                    else {
                        item7.strokeColor = SKColor.cyan
                        info.text = "???"
                        UserDefaults.standard.set(7, forKey: "selectedPowerUp")
                        deselectOtherBoxes(num: 7)
                    }
                    self.info.run(
                        SKAction.sequence([
                            SKAction.fadeAlpha(to: 1.0, duration: 0.5),
                            SKAction.wait(forDuration: 2.5),
                            SKAction.fadeOut(withDuration: 0.5)
                            ])
                    )
                }
                
                
                if node.name == "item8" {
                    info.removeAllActions()
                    if !UserDefaults.standard.bool(forKey: "item8isUnlocked") {
                        if carbonPoint > 1000 {
                            item8Picture.isHidden = false
                            item8Label.isHidden = true
                            item8Carbon.isHidden = true
                            item8.strokeColor = SKColor.cyan
                            info.text = "???"
                            UserDefaults.standard.set(8, forKey: "selectedPowerUp")
                            UserDefaults.standard.set(true, forKey: "item8isUnlocked")
                            deselectOtherBoxes(num: 8)
                            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "carbonPoint") - 1000, forKey: "carbonPoint")
                            carbonLabel.text = "\(UserDefaults.standard.integer(forKey: "carbonPoint"))"
                        }
                        else {
                            info.text = "More Carbon Points Needed"
                        }
                    }
                    else {
                        item8.strokeColor = SKColor.cyan
                        info.text = "???"
                        UserDefaults.standard.set(8, forKey: "selectedPowerUp")
                        deselectOtherBoxes(num: 8)
                    }
                    self.info.run(
                        SKAction.sequence([
                            SKAction.fadeAlpha(to: 1.0, duration: 0.5),
                            SKAction.wait(forDuration: 2.5),
                            SKAction.fadeOut(withDuration: 0.5)
                            ])
                    )
                }
                
                if node.name == "item9" {
                    info.removeAllActions()
                    if !UserDefaults.standard.bool(forKey: "item9isUnlocked") {
                        if carbonPoint > 1000 {
                            item9Picture.isHidden = false
                            item9Label.isHidden = true
                            item9Carbon.isHidden = true
                            item9.strokeColor = SKColor.cyan
                            info.text = "???"
                            UserDefaults.standard.set(9, forKey: "selectedPowerUp")
                            UserDefaults.standard.set(true, forKey: "item9isUnlocked")
                            deselectOtherBoxes(num: 9)
                            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "carbonPoint") - 1000, forKey: "carbonPoint")
                            carbonLabel.text = "\(UserDefaults.standard.integer(forKey: "carbonPoint"))"
                        }
                        else {
                            info.text = "More Carbon Points Needed"
                        }
                    }
                    else {
                        item9.strokeColor = SKColor.cyan
                        info.text = "???"
                        UserDefaults.standard.set(9, forKey: "selectedPowerUp")
                        deselectOtherBoxes(num: 9)
                    }
                    self.info.run(
                        SKAction.sequence([
                            SKAction.fadeAlpha(to: 1.0, duration: 0.5),
                            SKAction.wait(forDuration: 2.5),
                            SKAction.fadeOut(withDuration: 0.5)
                            ])
                    )
                }
                
                
                if node.name == "item10" {
                    info.removeAllActions()
                    if !UserDefaults.standard.bool(forKey: "item10isUnlocked") {
                        if carbonPoint > 1000 {
                            item10Picture.isHidden = false
                            item10Label.isHidden = true
                            item10Carbon.isHidden = true
                            item10.strokeColor = SKColor.cyan
                            info.text = "???"
                            UserDefaults.standard.set(10, forKey: "selectedPowerUp")
                            UserDefaults.standard.set(true, forKey: "item10isUnlocked")
                            deselectOtherBoxes(num: 10)
                            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "carbonPoint") - 1000, forKey: "carbonPoint")
                            carbonLabel.text = "\(UserDefaults.standard.integer(forKey: "carbonPoint"))"
                        }
                        else {
                            info.text = "More Carbon Points Needed"
                        }
                    }
                    else {
                        item10.strokeColor = SKColor.cyan
                        info.text = "???"
                        UserDefaults.standard.set(10, forKey: "selectedPowerUp")
                        deselectOtherBoxes(num: 10)
                    }
                    self.info.run(
                        SKAction.sequence([
                            SKAction.fadeAlpha(to: 1.0, duration: 0.5),
                            SKAction.wait(forDuration: 2.5),
                            SKAction.fadeOut(withDuration: 0.5)
                            ])
                    )
                }
                
               */
            }
        }
    }
    
    private func initializeShop() {
        
        
        var posX: CGFloat = 0.0
        var colorX: CGFloat = 0.0
        var colorY: CGFloat = 0.0
        var squareX: CGFloat = 0.0

        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                //print("iPhone 5 or 5S or 5C")
                posX = 60.0
                colorX = 20.0
                colorY = 150.0
                squareX = 155.0
            case 1334:
                //print("iPhone 6/6S/7/8")
                posX = 60.0
                colorX = 20.0
                colorY = 150.0
                squareX = 155.0
            case 1920, 2208:
                //print("iPhone 6+/6S+/7+/8+")
                posX = 60.0
                colorX = 20.0
                colorY = 150.0
                squareX = 155.0
            case 2436:
                //print("iPhone X, Xs")
                posX = 120.0
                colorX = 40.0
                colorY = 155.0
                squareX = 195.0
            case 2688:
                //print("iPhone Xs Max")
                posX = 120.0
                colorX = 40.0
                colorY = 155.0
                squareX = 195.0
            case 1792:
                //print("iPhone Xr")
                posX = 120.0
                colorX = 40.0
                colorY = 155.0
                squareX = 195.0
            default:
                //print("unknown")
                posX = 120.0
                colorX = 40.0
                colorY = 155.0
                squareX = 195.0
            }
        }
        
        carbonLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        carbonLabel.position = CGPoint(x: (frame.size.width / 2) - squareX - 10, y: (frame.size.height / 2) - 115)
        carbonLabel.fontSize = 41
        carbonLabel.isHidden = false
        carbonLabel.text = "\(UserDefaults.standard.integer(forKey: "carbonPoint"))"
        carbonLabel.fontColor = SKColor.white
        self.addChild(carbonLabel)
        
        let i1 = SKTexture(imageNamed: "diamond")
        carbon = SKSpriteNode(texture: i1)
        carbon.position = CGPoint(x: carbonLabel.frame.maxX + 37, y: (frame.size.height / 2) - 101)
        self.addChild(carbon)
        
        info = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        info.position = CGPoint(x: 0, y: -(frame.size.height / 2) + colorY + 25)
        info.fontSize = 28
        info.alpha = 0.0
        if UserDefaults.standard.integer(forKey: "selectedPowerUp") == 1 {
            info.text = "Double Carbon Points"
        }
        else if UserDefaults.standard.integer(forKey: "selectedPowerUp") == 2 {
            info.text = "Head Start"
        }
        else if UserDefaults.standard.integer(forKey: "selectedPowerUp") == 3 {
            info.text = "Skip A Level"
        }
        else if UserDefaults.standard.integer(forKey: "selectedPowerUp") == 4 {
            info.text = "Postmortem Boost"
        }
        else {
            info.text = "More Carbon Points Needed"
        }
        info.fontColor = SKColor.white
        self.addChild(info)
        
        instruction = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        instruction.position = CGPoint(x: info.position.x, y: info.position.y - 50)
        instruction.fontSize = 28
        instruction.isHidden = true
        instruction.alpha = 0.5
        //instruction.text = "(Tap Icon In-Game To Activate)"
        instruction.fontColor = SKColor.white
        self.addChild(instruction)
        
        
        item1 = SKShapeNode(rectOf: CGSize(width: 200, height: 100), cornerRadius: 10)
        item1.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        item1.zPosition = 1
        item1.lineWidth = 7
        item1.name = "item1"
        item1.fillColor = SKColor.clear
        item1.position = CGPoint(x: -(frame.size.width / 4) + colorX, y: (frame.size.height / 4))
        self.addChild(item1)
        
        item1Label = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        item1Label.position = CGPoint(x: -(frame.size.width / 4) + colorX - 23, y: (frame.size.height / 4) - 10)
        item1Label.fontSize = 30
        item1Label.text = "500"
        item1Label.fontColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        self.addChild(item1Label)
        
        item1Carbon = SKSpriteNode(texture: i1)
        item1Carbon.position = CGPoint(x: item1Label.frame.maxX + 23, y: (frame.size.height / 4))
        item1Carbon.setScale(0.7)
        self.addChild(item1Carbon)
        
        let i2 = SKTexture(imageNamed: "double")
        item1Picture = SKSpriteNode(texture: i2)
        item1Picture.name = "item1"
        item1Picture.position = CGPoint(x: item1.position.x, y: (frame.size.height / 4))
        item1Picture.isHidden = true
        self.addChild(item1Picture)
        
        
        
        item2 = SKShapeNode(rectOf: CGSize(width: 200, height: 100), cornerRadius: 10)
        item2.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        item2.zPosition = 1
        item2.lineWidth = 7
        item2.name = "item2"
        item2.fillColor = SKColor.clear
        item2.position = CGPoint(x: (frame.size.width / 4) - colorX, y: (frame.size.height / 4))
        self.addChild(item2)
        
        item2Label = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        item2Label.position = CGPoint(x: (frame.size.width / 4) - colorX - 23, y: (frame.size.height / 4) - 10)
        item2Label.fontSize = 30
        item2Label.text = "500"
        item2Label.fontColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        self.addChild(item2Label)
        
        item2Carbon = SKSpriteNode(texture: i1)
        item2Carbon.position = CGPoint(x: item2Label.frame.maxX + 23, y: (frame.size.height / 4))
        item2Carbon.setScale(0.7)
        self.addChild(item2Carbon)
        
        let i3 = SKTexture(imageNamed: "run")
        item2Picture = SKSpriteNode(texture: i3)
        item2Picture.name = "item2"
        item2Picture.position = CGPoint(x: item2.position.x, y: (frame.size.height / 4))
        item2Picture.isHidden = true
        self.addChild(item2Picture)
        
        
        
        item3 = SKShapeNode(rectOf: CGSize(width: 200, height: 100), cornerRadius: 10)
        item3.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        item3.zPosition = 1
        item3.lineWidth = 7
        item3.name = "item3"
        item3.fillColor = SKColor.clear
        item3.position = CGPoint(x: item1.position.x, y: item1.position.y - colorY)
        self.addChild(item3)
        
        item3Label = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        item3Label.position = CGPoint(x: item1.position.x - 23, y: item1.position.y - colorY - 10)
        item3Label.fontSize = 30
        item3Label.text = "500"
        item3Label.fontColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        self.addChild(item3Label)
        
        item3Carbon = SKSpriteNode(texture: i1)
        item3Carbon.position = CGPoint(x: item3Label.frame.maxX + 23, y: item1.position.y - colorY)
        item3Carbon.setScale(0.7)
        self.addChild(item3Carbon)
        
        let i4 = SKTexture(imageNamed: "escape")
        item3Picture = SKSpriteNode(texture: i4)
        item3Picture.name = "item3"
        item3Picture.position = CGPoint(x: item3.position.x, y: item3.position.y)
        item3Picture.isHidden = true
        self.addChild(item3Picture)
        
        
        
        item4 = SKShapeNode(rectOf: CGSize(width: 200, height: 100), cornerRadius: 10)
        item4.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        item4.zPosition = 1
        item4.lineWidth = 7
        item4.name = "item4"
        item4.fillColor = SKColor.clear
        item4.position = CGPoint(x: item2.position.x, y: item2.position.y - colorY)
        self.addChild(item4)
        
        item4Label = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        item4Label.position = CGPoint(x: item2.position.x - 23, y: item2.position.y - colorY - 10)
        item4Label.fontSize = 30
        item4Label.text = "500"
        item4Label.fontColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        self.addChild(item4Label)
        
        item4Carbon = SKSpriteNode(texture: i1)
        item4Carbon.position = CGPoint(x: item4Label.frame.maxX + 23, y: item2.position.y - colorY)
        item4Carbon.setScale(0.7)
        self.addChild(item4Carbon)
        
        let i5 = SKTexture(imageNamed: "catapult")
        item4Picture = SKSpriteNode(texture: i5)
        item4Picture.name = "item4"
        item4Picture.position = CGPoint(x: item4.position.x, y: item4.position.y)
        item4Picture.isHidden = true
        self.addChild(item4Picture)
        
        
        
        item5 = SKShapeNode(rectOf: CGSize(width: 200, height: 100), cornerRadius: 10)
        item5.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        item5.zPosition = 1
        item5.lineWidth = 7
        item5.name = "item5"
        item5.fillColor = SKColor.clear
        item5.position = CGPoint(x: item1.position.x, y: item3.position.y - colorY)
        self.addChild(item5)
        
        item5Label = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        item5Label.position = CGPoint(x: item3.position.x - 23, y: item3.position.y - colorY - 10)
        item5Label.fontSize = 30
        item5Label.text = "?"
        item5Label.fontColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        self.addChild(item5Label)
        
        item5Carbon = SKSpriteNode(texture: i1)
        item5Carbon.position = CGPoint(x: item5Label.frame.maxX + 23, y: item3.position.y - colorY)
        item5Carbon.setScale(0.7)
        self.addChild(item5Carbon)
        
        
         
        item6 = SKShapeNode(rectOf: CGSize(width: 200, height: 100), cornerRadius: 10)
        item6.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        item6.zPosition = 1
        item6.lineWidth = 7
        item6.name = "item6"
        item6.fillColor = SKColor.clear
        item6.position = CGPoint(x: item4.position.x, y: item4.position.y - colorY)
        self.addChild(item6)
        
        item6Label = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        item6Label.position = CGPoint(x: item4.position.x - 23, y: item4.position.y - colorY - 10)
        item6Label.fontSize = 30
        item6Label.text = "?"
        item6Label.fontColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        self.addChild(item6Label)
        
        item6Carbon = SKSpriteNode(texture: i1)
        item6Carbon.position = CGPoint(x: item6Label.frame.maxX + 23, y: item4.position.y - colorY)
        item6Carbon.setScale(0.7)
        self.addChild(item6Carbon)
        
        
        
        item7 = SKShapeNode(rectOf: CGSize(width: 200, height: 100), cornerRadius: 10)
        item7.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        item7.zPosition = 1
        item7.lineWidth = 7
        item7.name = "item7"
        item7.fillColor = SKColor.clear
        item7.position = CGPoint(x: item5.position.x, y: item5.position.y - colorY)
        self.addChild(item7)
        
        item7Label = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        item7Label.position = CGPoint(x: item5.position.x - 23, y: item5.position.y - colorY - 10)
        item7Label.fontSize = 30
        item7Label.text = "?"
        item7Label.fontColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        self.addChild(item7Label)
        
        item7Carbon = SKSpriteNode(texture: i1)
        item7Carbon.position = CGPoint(x: item7Label.frame.maxX + 23, y: item5.position.y - colorY)
        item7Carbon.setScale(0.7)
        self.addChild(item7Carbon)
        
        
        
        item8 = SKShapeNode(rectOf: CGSize(width: 200, height: 100), cornerRadius: 10)
        item8.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        item8.zPosition = 1
        item8.lineWidth = 7
        item8.name = "item8"
        item8.fillColor = SKColor.clear
        item8.position = CGPoint(x: item6.position.x, y: item6.position.y - colorY)
        self.addChild(item8)
        
        item8Label = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        item8Label.position = CGPoint(x: item6.position.x - 23, y: item6.position.y - colorY - 10)
        item8Label.fontSize = 30
        item8Label.text = "?"
        item8Label.fontColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        self.addChild(item8Label)
        
        item8Carbon = SKSpriteNode(texture: i1)
        item8Carbon.position = CGPoint(x: item8Label.frame.maxX + 23, y: item6.position.y - colorY)
        item8Carbon.setScale(0.7)
        self.addChild(item8Carbon)
 
        
        
        item9 = SKShapeNode(rectOf: CGSize(width: 200, height: 100), cornerRadius: 10)
        item9.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        item9.zPosition = 1
        item9.lineWidth = 7
        item9.name = "item9"
        item9.fillColor = SKColor.clear
        item9.position = CGPoint(x: item7.position.x, y: item7.position.y - colorY)
        self.addChild(item9)
        
        item9Label = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        item9Label.position = CGPoint(x: item7.position.x - 23, y: item7.position.y - colorY - 10)
        item9Label.fontSize = 30
        item9Label.text = "?"
        item9Label.fontColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        self.addChild(item9Label)
        
        item9Carbon = SKSpriteNode(texture: i1)
        item9Carbon.position = CGPoint(x: item9Label.frame.maxX + 23, y: item7.position.y - colorY)
        item9Carbon.setScale(0.7)
        self.addChild(item9Carbon)
        
        
        
        item10 = SKShapeNode(rectOf: CGSize(width: 200, height: 100), cornerRadius: 10)
        item10.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        item10.zPosition = 1
        item10.lineWidth = 7
        item10.name = "item10"
        item10.fillColor = SKColor.clear
        item10.position = CGPoint(x: item8.position.x, y: item8.position.y - colorY)
        self.addChild(item10)
        
        item10Label = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        item10Label.position = CGPoint(x: item8.position.x - 23, y: item8.position.y - colorY - 10)
        item10Label.fontSize = 30
        item10Label.text = "?"
        item10Label.fontColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        self.addChild(item10Label)
        
        item10Carbon = SKSpriteNode(texture: i1)
        item10Carbon.position = CGPoint(x: item10Label.frame.maxX + 23, y: item8.position.y - colorY)
        item10Carbon.setScale(0.7)
        self.addChild(item10Carbon)
        
        
        
        shopLogo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        shopLogo.zPosition = 1
        shopLogo.position = CGPoint(x: 0, y: (frame.size.height / 2) - 201)
        shopLogo.fontSize = 61
        shopLogo.text = "Shop"
        //gameLogo.fontColor = SKColor(red: 36/255, green: 93/255, blue: 104/255, alpha: 1)
        //gameLogo.fontColor = SKColor(red: 245/255, green: 208/255, blue: 76/255, alpha: 1)
        /*
        if isInsane {
            shopLogo.fontColor = SKColor.red
        }
        else {
            shopLogo.fontColor = SKColor.cyan
        }
 */
        shopLogo.fontColor = SKColor.cyan

        self.addChild(shopLogo)
        
        let imageTexture1 = SKTexture(imageNamed: "back")
        backButton = SKSpriteNode(texture: imageTexture1)
        self.isUserInteractionEnabled = true
        backButton.name = "back_button"
        backButton.isHidden = false
        backButton.zPosition = 0.5
        backButton.position = CGPoint(x: -(frame.size.width / 2) + posX, y: (frame.size.height / 2) - 75)
        //print(frame.size.height)
        backButton.setScale(0.804)
        self.addChild(backButton)
        
        touchBackButton = SKShapeNode()
        touchBackButton.isHidden = false
        touchBackButton.zPosition = 1
        touchBackButton.position = CGPoint(x: -(frame.size.width / 2) + posX, y: (frame.size.height / 2) - 75)
        touchBackButton.fillColor = SKColor.clear
        touchBackButton.strokeColor = SKColor.clear
        let tl = CGPoint(x: -50, y: 50)
        let bl = CGPoint(x: -50, y: -50)
        let tr = CGPoint(x: 50, y: 50)
        let br = CGPoint(x: 50, y: -50)
        let pos = CGMutablePath()
        pos.addLine(to: tl)
        pos.addLines(between: [tl, tr, br, bl])
        self.touchBackButton.path = pos
        touchBackButton.name = "back_button"
        self.addChild(touchBackButton)
        
        
    }
    
    func deselectOtherBoxes(num: Int) {
        if num != 1 {
            item1.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        }
        if num != 2 {
            item2.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        }
        if num != 3 {
            item3.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        }
        if num != 4 {
            item4.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        }
        if num != 5 {
            item5.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        }
        if num != 6 {
            item6.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        }
        if num != 7 {
            item7.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        }
        if num != 8 {
            item8.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        }
        if num != 9 {
            item9.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        }
        if num != 10 {
            item10.strokeColor = SKColor(red: 255/255, green: 130/255, blue: 210/255, alpha: 1)
        }
    }
    
    func updateShop() {

        if UserDefaults.standard.bool(forKey: "item1isUnlocked") {
            item1Picture.isHidden = false
            item1Label.isHidden = true
            item1Carbon.isHidden = true
        }
        if UserDefaults.standard.integer(forKey: "selectedPowerUp") == 1 {
            item1.strokeColor = SKColor.cyan
        }
        
        
        if UserDefaults.standard.bool(forKey: "item2isUnlocked") {
            item2Picture.isHidden = false
            item2Label.isHidden = true
            item2Carbon.isHidden = true
        }
        if UserDefaults.standard.integer(forKey: "selectedPowerUp") == 2 {
            item2.strokeColor = SKColor.cyan
        }
        
        
        if UserDefaults.standard.bool(forKey: "item3isUnlocked") {
            item3Picture.isHidden = false
            item3Label.isHidden = true
            item3Carbon.isHidden = true
        }
        if UserDefaults.standard.integer(forKey: "selectedPowerUp") == 3 {
            item3.strokeColor = SKColor.cyan
        }
        
        
        if UserDefaults.standard.bool(forKey: "item4isUnlocked") {
            item4Picture.isHidden = false
            item4Label.isHidden = true
            item4Carbon.isHidden = true
        }
        if UserDefaults.standard.integer(forKey: "selectedPowerUp") == 4 {
            item4.strokeColor = SKColor.cyan
        }
    }

    
    
}
