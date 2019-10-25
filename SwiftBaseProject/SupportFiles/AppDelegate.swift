//
//  AppDelegate.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/12/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  static let usernameKey = "com.base.project.username"
  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let rootVC = AppRouter.sharedInstance.rootViewController
    window?.rootViewController = rootVC
    window?.makeKeyAndVisible()
    return true
  }

  static func getUserNameFromDefaults() -> String? {
    return UserDefaults.standard.string(forKey: AppDelegate.usernameKey)
  }

  static func saveUserNameOnDefaults(username: String) {
    UserDefaults.standard.set(username, forKey: usernameKey)
  }
}
