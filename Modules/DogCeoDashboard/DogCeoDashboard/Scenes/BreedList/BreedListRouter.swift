//
//  BreedListRouter.swift
//  DogCeoDashboard
//
//  Created by Vitor on 04-04-21.
//

import DogCeoCommons

protocol BreedListRouterProtocol {
    var viewController: UIViewController? { get set }
    var managerAPI: ManagerRequestAPI? { get set }
    func routeToBreedImages(breed: String)
}

class BreedListRouter: BreedListRouterProtocol {
    weak var viewController: UIViewController?
    var managerAPI: ManagerRequestAPI?

    func routeToBreedImages(breed: String) {

        if let manager = managerAPI,
           let navigation = self.viewController?.navigationController {
            let dest = BreedImagesViewController(
                managerAPI: manager
            )
            dest.breedSelected = breed
            DispatchQueue.main.async {
                navigation.pushViewController(dest, animated: true)
            }
        }

    }

}
