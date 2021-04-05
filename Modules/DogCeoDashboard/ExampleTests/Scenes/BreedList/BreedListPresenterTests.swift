//
//  BreedListPresenterTests.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

import DogCeoCommons
@testable import DogCeoDashboard
import XCTest

class BreedListPresenterTests: XCTestCase {

    var sut: BreedListPresenter!
    var spyManagerAPI: MockManagerRequestAPI!
    var spyOutput: BreedListViewControllerSpy!
    var spyWorker: BreedListWorkerSpy!

    override func setUp() {
        super.setUp()
        spyManagerAPI = .init()
        spyOutput = .init(manager: spyManagerAPI)
        spyWorker = .init(manager: spyManagerAPI)

        sut = .init()
        sut.output = spyOutput
        sut.worker = spyWorker
    }
    override func tearDown() {
        spyOutput = nil
        spyWorker = nil
        sut = nil
        super.tearDown()
    }

    func testLoadDataShouldDisplayData() {
        // Given
        let expectedItems = ["1", "2", "3"]
        spyWorker.response = BreedResponse(
            status: "success",
            items: expectedItems
        )

        // When
        sut.loadData()

        // Then
        XCTAssertTrue(spyOutput.displayDataCalled)
        XCTAssertEqual(spyOutput.displayDataResponse?.items, expectedItems)
    }

    func testLoadDataShouldDisplayError() {
        // Given
        spyWorker.error = NetworkError.unknownError

        // When
        sut.loadData()

        // Then
        XCTAssertTrue(spyOutput.displayErrorCalled)
    }

}

