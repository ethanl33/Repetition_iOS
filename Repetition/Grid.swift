//
//  Grid.swift
//  Repetition
//
//  Created by Ethan Lee on 8/29/18.
//  Copyright © 2018 Ethan Lee. All rights reserved.
//

import SpriteKit

class Grid:SKSpriteNode {
    var rows:Int!
    var cols:Int!
    var blockSize:CGFloat!
    
    var solution: [(Int, Int)] = []
    var guess: [(Int, Int)] = []

    var isSimulationFinished = false
    
    var gameManager = GameManager()
    
    
    convenience init?(blockSize:CGFloat,rows:Int,cols:Int) {
        guard let texture = Grid.gridTexture(blockSize: blockSize,rows: rows, cols:cols) else {
            return nil
        }
        
        self.init(texture: texture, color:SKColor.clear, size: texture.size())
        self.blockSize = blockSize
        self.rows = rows
        self.cols = cols
        
        
        self.isUserInteractionEnabled = true
        
    }
    
    
    
    class func gridTexture(blockSize:CGFloat,rows:Int,cols:Int) -> SKTexture? {
        // Add 1 to the height and width to ensure the borders are within the sprite
        let size = CGSize(width: CGFloat(cols)*blockSize + 1.0, height: CGFloat(rows)*blockSize + 1.0)
        UIGraphicsBeginImageContext(size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let bezierPath = UIBezierPath()
        let offset:CGFloat = 0.5
        // Draw vertical lines
        for i in 0...cols {
            let x = CGFloat(i)*blockSize + offset
            bezierPath.move(to: CGPoint(x: x, y: 0))
            bezierPath.addLine(to: CGPoint(x: x, y: size.height))
        }
        // Draw horizontal lines
        for i in 0...rows {
            let y = CGFloat(i)*blockSize + offset
            bezierPath.move(to: CGPoint(x: 0, y: y))
            bezierPath.addLine(to: CGPoint(x: size.width, y: y))
        }
        SKColor.white.setStroke()
        bezierPath.lineWidth = 1.0
        bezierPath.stroke()
        context.addPath(bezierPath.cgPath)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return SKTexture(image: image!)
    }
    
    func gridPosition(row:Int, col:Int) -> CGPoint {
        let offset = blockSize / 2.0 + 0.5
        let x = CGFloat(col) * blockSize - (blockSize * CGFloat(cols)) / 2.0 + offset
        let y = CGFloat(rows - row - 1) * blockSize - (blockSize * CGFloat(rows)) / 2.0 + offset
        return CGPoint(x:x, y:y)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isSimulationFinished == true {
            for touch in touches {
                let position = touch.location(in:self)
                let node = atPoint(position)
                
                if node != self {
                    let action = SKAction.rotate(byAngle:CGFloat.pi*2, duration: 1)
                    node.run(action)
                }
                else {
                    let y = size.width / 2 + position.x
                    let x = size.height / 2 - position.y
                    let row = Int(floor(x / blockSize))
                    let col = Int(floor(y / blockSize))
                    print("\(row) \(col)")
                    
                    let box = SKShapeNode(rectOf: CGSize(width: blockSize, height: blockSize))
                    box.isUserInteractionEnabled = true
                    box.name = "box"
                    box.fillColor = SKColor.white
                    box.position = gridPosition(row: row, col: col)
                    self.addChild(box)
                    
                    box.run(
                        SKAction.sequence([
                            SKAction.wait(forDuration: 0.2),
                            SKAction.removeFromParent()
                            ])
                    )
                }
            }
        }
    }
    func runSimulation(){
        let coordinate = getCoordinate()
        var box: SKShapeNode!
        box = SKShapeNode(rectOf: CGSize(width: blockSize, height: blockSize))
        box.name = "box"
        box.fillColor = SKColor.white
        box.isHidden = true
        self.addChild(box)
        
        box.run(
            SKAction.sequence([
                SKAction.move(to: coordinate, duration: 0.001),
                SKAction.unhide(),
                SKAction.wait(forDuration: 0.7),
                SKAction.hide(),
                SKAction.removeFromParent()
                ])
        )
        
    }
    

    
    func getCoordinate() -> CGPoint{
        //print(gameManager.currentScore)
        let row = Int(arc4random_uniform(4))
        let col = Int(arc4random_uniform(3))
        let position = gridPosition(row: row, col: col)
        return position
    }
    
}