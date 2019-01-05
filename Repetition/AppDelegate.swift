//
//  AppDelegate.swift
//  Repetition
//
//  Created by Ethan Lee on 8/22/18.
//  Copyright © 2018 Ethan Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let defaults = UserDefaults.standard
        let defaultValue = ["bestScore" : 1]
        defaults.register(defaults: defaultValue)
        
        let defaults2 = UserDefaults.standard
        let defaultValue2 = ["lastScore" : 1]
        defaults2.register(defaults: defaultValue2)
        
        let defaults3 = UserDefaults.standard
        let defaultValue3 = ["carbonPoint" : 0]
        defaults3.register(defaults: defaultValue3)
        
        let defaults4 = UserDefaults.standard
        let defaultValue4 = ["isInsane" : false]
        defaults4.register(defaults: defaultValue4)
        
        let defaults5 = UserDefaults.standard
        let defaultValue5 = ["isMute" : true]
        defaults5.register(defaults: defaultValue5)
        
        let defaults6 = UserDefaults.standard
        let defaultValue6 = ["selectedPowerUp" : 0]
        defaults6.register(defaults: defaultValue6)
        
        let d1 = UserDefaults.standard
        let dv1 = ["item1isUnlocked" : false]
        d1.register(defaults: dv1)
        
        let d2 = UserDefaults.standard
        let dv2 = ["item2isUnlocked" : false]
        d2.register(defaults: dv2)
        
        let d3 = UserDefaults.standard
        let dv3 = ["item3isUnlocked" : false]
        d3.register(defaults: dv3)
        
        let d4 = UserDefaults.standard
        let dv4 = ["item4isUnlocked" : false]
        d4.register(defaults: dv4)
        
        let d5 = UserDefaults.standard
        let dv5 = ["item5isUnlocked" : false]
        d5.register(defaults: dv5)
        
        let d6 = UserDefaults.standard
        let dv6 = ["item6isUnlocked" : false]
        d6.register(defaults: dv6)
        
        let d7 = UserDefaults.standard
        let dv7 = ["item7isUnlocked" : false]
        d7.register(defaults: dv7)
        
        let d8 = UserDefaults.standard
        let dv8 = ["item8isUnlocked" : false]
        d8.register(defaults: dv8)
        
        let d9 = UserDefaults.standard
        let dv9 = ["item9isUnlocked" : false]
        d9.register(defaults: dv9)
        
        let d10 = UserDefaults.standard
        let dv10 = ["item10isUnlocked" : false]
        d10.register(defaults: dv10)

        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

