//
//  AppDelegate.swift
//  coduku
//
//  Created by localadmin on 22.03.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    registerForNotifications()
    return true
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    //
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

extension AppDelegate: UNUserNotificationCenterDelegate {

// code 1
func registerForNotifications() {
  let center  = UNUserNotificationCenter.current()
  center.delegate = self
  center.requestAuthorization(options: [.provisional]) { (granted, error) in
    if error == nil{
      DispatchQueue.main.async {
        UIApplication.shared.registerForRemoteNotifications()
      }
    } else {
      print("error ",error)
    }
  }
}

  func application( _ application: UIApplication,
                    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
    token = tokenParts.joined()
    print("Device Token: \n\(token)\n")
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("failed error ",error)
  }
}

