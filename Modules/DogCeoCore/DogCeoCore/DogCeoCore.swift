//
//  DogCeoCore.swift
//  DogCeoCore
//
//  Created by Vitor on 03-04-21.
//

import DogCeoUIKit
import DogCeoCommons
import DogCeoDashboard
import UIKit

public class DogCeoCore {
    
    public static func assembleCore(enviroment: Environment = .prod) -> UIViewController {

        let managerRequestAPIImpl = getManagerRequestAPI()

        let dashboardFactory = DashboardFactory(managerAPI: managerRequestAPIImpl)
        let rootViewController = dashboardFactory.rootViewController()
        let nav = NavigationViewController(rootViewController: rootViewController)
        return nav
    }

    static func getManagerRequestAPI() -> ManagerRequestAPI {
        AlamofireManagerRequestAPI()
    }
}
