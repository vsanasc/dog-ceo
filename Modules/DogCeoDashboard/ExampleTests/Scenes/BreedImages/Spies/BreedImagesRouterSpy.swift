//
//  BreedImagesRouterSpy.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

import DogCeoCommons
@testable import DogCeoDashboard

class BreedImagesRouterSpy: BreedImagesRouterProtocol {

    var viewController: UIViewController?
    var managerAPI: ManagerRequestAPI?

    // MARK: - SpyValues
    private(set) var routeToBreedImagesImages: [String] = []
    private(set) var routeToBreedImagesSelected = 0


    // MARK: - Called Properties
    private(set) var routeToPreviewImagesCalled = false

    // MARK: - Methods
    func routeToPreviewImages(images: [String], selected: Int) {
        routeToPreviewImagesCalled = true
        routeToBreedImagesImages = images
        routeToBreedImagesSelected = selected
    }
}

