//
//  DashboardFactory.swift
//  DogCeoDashboard
//
//  Created by Vitor on 03-04-21.
//

import DogCeoCommons


public class DashboardFactory: DependencyFactory {
    required public init() { }
    public func rootViewController() -> UIViewController {
        BreedListViewController()
    }
}
