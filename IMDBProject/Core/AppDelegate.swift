//
//  AppDelegate.swift
//  IMDBProject
//
//  Created by Yakup Demir on 15.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController : UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        startApplication()
        
        
        return true
    }

  
    private func startApplication(){
        let controller: MainViewController = MainViewController.loadFromNib()

         navigationController = UINavigationController(rootViewController: controller)
         self.navigationController!.navigationBar.backgroundColor = .white
         self.navigationController!.navigationBar.barTintColor = .white
         self.navigationController!.navigationBar.tintColor = .black
         self.navigationController!.navigationBar.shadowImage = UIImage()
         self.navigationController!.navigationBar.isTranslucent = false
         self.navigationController!.navigationBar.topItem?.title = ""

         window = UIWindow(frame: UIScreen.main.bounds)
         window?.rootViewController = navigationController
         window?.makeKeyAndVisible()
    }


}

