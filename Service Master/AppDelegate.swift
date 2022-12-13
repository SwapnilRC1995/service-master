//
//  AppDelegate.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-11-30.
//

import UIKit
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if user != nil{
                let controller = storyboard.instantiateViewController(withIdentifier: "LoggedInDashboardViewController") 
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
                
            }else{
                let controller = storyboard.instantiateViewController(withIdentifier: "ViewController") 
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
                
            }
        }
        
        return true
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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }

}

