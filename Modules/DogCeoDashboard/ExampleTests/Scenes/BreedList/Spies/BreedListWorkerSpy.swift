//
//  BreedListWorkerSpy.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

import DogCeoCommons
@testable import DogCeoDashboard

class BreedListWorkerSpy: BreedListWorkerProtocol {

    // MARK: - Settings
    var response: Any?
    var error: Error = NetworkError.unknownError

    // MARK: - Called properties
    private(set) var getListCalled = false


    // MARK: - Methods
    required init(manager: ManagerRequestAPI) { }

    func getList(
        onSuccess: @escaping ((BreedResponse) -> Void),
        onError: @escaping ((Error) -> Void)
    ) {
        getListCalled = true
        if let response = response as? BreedResponse {
            onSuccess(response)
        } else {
            onError(error)
        }

    }


}
