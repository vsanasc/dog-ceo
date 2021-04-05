//
//  BreedImagesPresenterTests.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

import DogCeoCommons
@testable import DogCeoDashboard
import XCTest

class BreedImagesPresenterTests: XCTestCase {

    var sut: BreedImagesPresenter!
    var spyManagerAPI: MockManagerRequestAPI!
    var spyOutput: BreedImagesViewControllerSpy!
    var spyWorker: BreedImagesWorkerSpy!

    override func setUp() {
        super.setUp()
        spyManagerAPI = .init()
        spyOutput = .init(managerAPI: spyManagerAPI)
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
        let expectedBreed = "test"
        spyWorker.response = ImageResponse(
            status: "success",
            images: expectedItems
        )
        let request = BreedImagesModels.LoadData.Request(breed: expectedBreed)

        // When
        sut.loadData(request: request)

        // Then
        XCTAssertTrue(spyOutput.displayDataCalled)
        XCTAssertEqual(spyWorker.getListBreed, expectedBreed)
        XCTAssertEqual(spyOutput.displayDataResponse?.items, expectedItems)
    }

    func testLoadDataShouldDisplayError() {
        // Given
        spyWorker.error = NetworkError.unknownError

        // When
        sut.loadData(request: .init(breed: ""))

        // Then
        XCTAssertTrue(spyOutput.displayErrorCalled)
    }

}

