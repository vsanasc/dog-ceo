//
//  AppDelegate.swift
//  Example
//
//  Created by Vitor on 04-04-21.
//

import DogCeoDashboard
import DogCeoCore
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let factory = DashboardFactory(managerAPI: URLSessionManagerRequestAPI())
        window = .init()
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(
            rootViewController: factory.rootViewController()
        )

        return true
    }

}
