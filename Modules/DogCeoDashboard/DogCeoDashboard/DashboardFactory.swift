//
//  DashboardFactory.swift
//  DogCeoDashboard
//
//  Created by Vitor on 03-04-21.
//

import DogCeoCommons


public class DashboardFactory: DependencyFactory {
    let managerAPI: ManagerRequestAPI
    public required init(managerAPI: ManagerRequestAPI) {
        self.managerAPI = managerAPI
    }
    public func rootViewController() -> UIViewController {
        BreedListViewController(manager: managerAPI)
    }
}
