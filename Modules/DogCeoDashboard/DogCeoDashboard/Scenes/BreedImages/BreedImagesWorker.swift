//
//  BreedImagesWorker.swift
//  DogCeoDashboard
//
//  Created by Vitor on 04-04-21.
//

import DogCeoCommons

protocol BreedImagesWorkerProtocol {
    init(manager: ManagerRequestAPI)
    func getList(
        breed: String,
        onSuccess: @escaping ((_ response: ImageResponse) -> Void),
        onError: @escaping ((_ error: Error) -> Void)
    )
}

class BreedImagesWorker: BreedImagesWorkerProtocol {

    private let manager: ManagerRequestAPI

    required init(manager: ManagerRequestAPI) {
        self.manager = manager
    }

    func getList(
        breed: String,
        onSuccess: @escaping ((_ response: ImageResponse) -> Void),
        onError: @escaping ((_ error: Error) -> Void)
    ) {
        let path: NetworkAPIPaths = .images(slug: breed)
        manager.fetch(
            request: .init(url: path.getURL()),
            decode: ImageResponse.self,
            completion: { result in
                switch result {
                case .success(let parsed):
                    onSuccess(parsed)
                case .error(let error):
                    onError(error)
                }
            }
        )
    }

}
