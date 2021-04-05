//
//  BreedListPresenterSpy.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

@testable import DogCeoDashboard

class BreedListPresenterSpy: BreedListPresenterProtocol {
    var output: BreedListPresenterOutput?
    var worker: BreedListWorkerProtocol?

    // MARK: - Called properties
    private(set) var loadDataCalled = false

    // MARK: - Methods
    func loadData() {
        loadDataCalled = true
    }
}
