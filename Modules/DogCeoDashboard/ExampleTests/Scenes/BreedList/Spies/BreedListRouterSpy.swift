//
//  BreedListRouterSpy.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

import DogCeoCommons
@testable import DogCeoDashboard

class BreedListRouterSpy: BreedListRouterProtocol {
    var viewController: UIViewController?
    var managerAPI: ManagerRequestAPI?

    // MARK: - SpyValues
    private(set) var routeToBreedImagesBreed = ""


    // MARK: - Called Properties
    private(set) var routeToBreedImagesCalled = false

    // MARK: - Methods
    func routeToBreedImages(breed: String) {
        routeToBreedImagesCalled = true
        routeToBreedImagesBreed = breed
    }
}

