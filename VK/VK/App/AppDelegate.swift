//
//  AppDelegate.swift
//  VK
//
//  Created by Антон Васильченко on 13.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(getDocumentsDirectory())
        
        FirebaseApp.configure()
        
        return true
    }
    
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }

}

