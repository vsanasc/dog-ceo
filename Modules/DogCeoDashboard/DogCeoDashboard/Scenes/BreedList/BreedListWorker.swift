//
//  BreedListWorker.swift
//  DogCeoDashboard
//
//  Created by Vitor on 04-04-21.
//

import DogCeoCommons

protocol BreedListWorkerProtocol {
    init(manager: ManagerRequestAPI)
    func getList(
        onSuccess: @escaping ((_ response: BreedResponse) -> Void),
        onError: @escaping ((_ error: Error) -> Void)
    )
}

class BreedListWorker: BreedListWorkerProtocol {

    private let manager: ManagerRequestAPI

    required init(manager: ManagerRequestAPI) {
        self.manager = manager
    }

    func getList(
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

}
