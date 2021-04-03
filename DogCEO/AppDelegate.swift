//
//  AppDelegate.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let nav = NavigationViewController(rootViewController: BreedListViewController())

        window = .init()
        window?.makeKeyAndVisible()
        window?.rootViewController = nav

        return true
    }

}

