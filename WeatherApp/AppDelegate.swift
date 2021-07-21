//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Dev on 2021-07-19.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NetworkConnectionManager.shared.startMonitoring()
        return true
    }
    
}

