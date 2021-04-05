//
//  BreedImagesWorkerSpy.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

import DogCeoCommons
@testable import DogCeoDashboard

class BreedImagesWorkerSpy: BreedImagesWorkerProtocol {

    // MARK: - Settings
    var response: Any?
    var error: Error = NetworkError.unknownError

    // MARK: - Spy Values
    private(set) var getListBreed = ""

    // MARK: - Called properties
    private(set) var getListCalled = false

    // MARK: - Methods
    required init(manager: ManagerRequestAPI) { }

    func getList(
        breed: String,
        onSuccess: @escaping ((ImageResponse) -> Void),
        onError: @escaping ((Error) -> Void)
    ) {
        getListCalled = true
        getListBreed = breed
        if let response = response as? ImageResponse {
            onSuccess(response)
        } else {
            onError(error)
        }

    }


}
