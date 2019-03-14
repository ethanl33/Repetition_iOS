//
//  GameViewController.swift
//  Repetition
//
//  Created by Ethan Lee on 8/22/18.
//  Copyright © 2018 Ethan Lee. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    static let sharedHelper = GameViewController()
    var audioPlayer: AVAudioPlayer?
    
    
    func startBackgroundMusic() {
        /*
        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "wav")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
 */
        
        let bSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "repetition", ofType: "wav")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:bSound as URL)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
        
        
    }
    
    func muteBackgroundMusic() {
        /*
        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "wav")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
            audioPlayer!.stop()
            
        } catch {
            print("Cannot pause the file")
        }
 */
        
        let bSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "repetition", ofType: "wav")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:bSound as URL)
            audioPlayer!.stop()
            
        } catch {
            print("Cannot pause the file")
        }
        
    }
    
    func musicIsPlaying() -> Bool {
        return audioPlayer?.isPlaying ?? false
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                //scene.scaleMode = .aspectFill
                //scene.scaleMode = .aspectFit
                if UIDevice().userInterfaceIdiom == .phone {
                    switch UIScreen.main.nativeBounds.height {
                    case 1136:
                        //print("iPhone 5 or 5S or 5C")
                        scene.scaleMode = .aspectFit
                    case 1334:
                        //print("iPhone 6/6S/7/8")
                        scene.scaleMode = .aspectFit
                    case 1920, 2208:
                        //print("iPhone 6+/6S+/7+/8+")
                        scene.scaleMode = .aspectFit
                    case 2436:
                        //print("iPhone X, Xs")
                        scene.scaleMode = .aspectFill
                    case 2688:
                        //print("iPhone Xs Max")
                        scene.scaleMode = .aspectFill
                    case 1792:
                        //print("iPhone Xr")
                        scene.scaleMode = .aspectFill
                    default:
                        //print("unknown")
                        scene.scaleMode = .aspectFit
                    }
                }

                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            // test 123
            
            view.showsFPS = false //change to true for developer info
            view.showsNodeCount = false //change to true for developer info
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
