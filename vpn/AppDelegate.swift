//
//  AppDelegate.swift
//  vpn
//
//  Created by i-chou on 2018/2/6.
//  Copyright © 2018年 i-chou. All rights reserved.
//

import UIKit
import KeychainAccess

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var defaultNavConfig: navConfig = navConfig.init(backColor: UIColor.white,
                                                     shadowImage: UIImage.image(with: .groupTableViewBackground, size: ccs(k_SCREEN_W, 1))!,
                                                     tintColor: UIColorFromRGB(0x292929),
                                                     isTrunslate: false)


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.setupBugly()
        self.setupHomeVC()
        
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
    
    func setupHomeVC() {
        
        let homeVC = HomeVC()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = kColor_Background
        self.window?.rootViewController = homeVC
        self.window?.makeKeyAndVisible()
    }
    
    func setupBugly() {
        Bugly.start(withAppId: k_Bugly_App_ID)
        //TODO: !!!!!发版时remove!!!!
        //        BuglyConfig().channel = "FIR"
        if Keychain(service: k_Service)[k_UserID] != nil {
            Bugly.setUserIdentifier(Keychain(service: k_Service)[k_UserID]!)
        }
        //        BuglyConfig().reportLogLevel = BuglyLogLevel.info
        
        #if DEBUG
            BuglyConfig().debugMode = true
            BuglyConfig().blockMonitorEnable = true
        #else
            BuglyConfig().debugMode = false
        #endif
        //TODO: remove this
        //        BuglyConfig().debugMode = true
    }

}

