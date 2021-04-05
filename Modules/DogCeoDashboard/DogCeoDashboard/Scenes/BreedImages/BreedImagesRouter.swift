//
//  BreedImagesRouter.swift
//  DogCeoDashboard
//
//  Created by Vitor on 04-04-21.
//

import DogCeoCommons
import DogCeoUIKit

protocol BreedImagesRouterProtocol {
    var viewController: UIViewController? { get set }
    func routeToPreviewImages(images: [String], selected: Int)
}

class BreedImagesRouter: BreedImagesRouterProtocol {
    weak var viewController: UIViewController?

    func routeToPreviewImages(images: [String], selected: Int) {
        if let navigation = viewController?.navigationController {
            let dest = ImagesPreviewViewController(
                images: images,
                selected: selected
            )
            DispatchQueue.main.async {
                navigation.pushViewController(dest, animated: true)
            }
        }
    }
}
