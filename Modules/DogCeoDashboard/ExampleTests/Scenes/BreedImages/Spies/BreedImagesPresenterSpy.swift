//
//  BreedListPresenterSpy.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

@testable import DogCeoDashboard

class BreedImagesPresenterSpy: BreedImagesPresenterProtocol {
    var output: BreedImagesPresenterOutput?
    var worker: BreedImagesWorkerProtocol?

    // MARK: - Spy Request
    private(set) var loadDataRequest: BreedImagesModels.LoadData.Request?

    // MARK: - Called properties
    private(set) var loadDataCalled = false

    // MARK: - Methods
    func loadData(request: BreedImagesModels.LoadData.Request) {
        loadDataCalled = true
        loadDataRequest = request
    }
}
