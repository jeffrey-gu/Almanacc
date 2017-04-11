//
//  AppDelegate.swift
//  FacebookTest
//
//  Created by Jeffrey Gu on 4/1/17.
//  Copyright © 2017 Jeffrey Gu. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

import FBSDKCoreKit
import FBSDKLoginKit



// https://medium.com/ios-os-x-development/a-simple-swift-login-implementation-with-facebook-sdk-for-ios-version-4-0-1f313ae814da
// https://developers.facebook.com/docs/facebook-login/ios/v2.3
// http://jgreen3d.com/facebook-sdk-swift-3/

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return SDKApplicationDelegate.shared.application(application, open:url, sourceApplication:sourceApplication, annotation:annotation)
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
        //App activation code
        FBSDKAppEvents.activateApp()

    }
    
    // lol what is this for anymore (isn't login handled on the view controller now:
    let facebookReadPermissions = ["public_profile", "email", "user_about_me", "user_friends", "name", "user_hometown", "user_location", "user_education_history", "user_work_history"]
    //Some other options: "user_about_me", "user_birthday", "user_hometown", "user_likes", "user_interests", "user_photos", "friends_photos", "friends_hometown", "friends_location", "friends_education_history"
    

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    

}

