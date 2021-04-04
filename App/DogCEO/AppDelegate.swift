//
//  AppDelegate.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import UIKit
import DogCeoCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let entryPoint = DogCeoCore.assembleCore(enviroment: .dev)
        window = .init()
        window?.makeKeyAndVisible()
        window?.rootViewController = entryPoint

        return true
    }

}
