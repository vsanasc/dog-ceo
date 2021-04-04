//
//  WorkerAPI.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import DogCeoCommons

public class WorkerAPI {

    private let manager: ManagerRequestAPI

    init(manager: ManagerRequestAPI){
        self.manager = manager
    }

    func getBreedsList(
        onSuccess: @escaping ((_ response: BreedResponse) -> Void),
        onError: @escaping ((_ error: Error) -> Void)
    ) {
        let path: NetworkAPIPaths = .list
        manager.fetch(
            request: .init(url: path.getURL()),
            decode: BreedResponse.self,
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

    func getImagesList(
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
