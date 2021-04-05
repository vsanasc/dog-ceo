//
//  BreedImagesViewControllerTests.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

@testable import DogCeoDashboard
import XCTest

class BreedImagesViewControllerTests: XCTestCase {

    var sut: BreedImagesViewController!
    var spyManagerAPI: MockManagerRequestAPI!
    var spyPresenter: BreedImagesPresenterSpy!
    var spyRouter: BreedImagesRouterSpy!
    var spyCollectionView: CollectionViewSpy!

    override func setUp() {
        super.setUp()
        spyRouter = .init()
        spyCollectionView = .init(frame: .zero, collectionViewLayout: .init())
        spyPresenter = .init()
        spyManagerAPI = .init()

        sut = .init(managerAPI: spyManagerAPI)
        sut.collectionView = spyCollectionView
        sut.presenter = spyPresenter
        sut.router = spyRouter
    }
    override func tearDown() {
        spyRouter = nil
        spyCollectionView = nil
        spyPresenter = nil
        spyManagerAPI = nil
        sut = nil
        super.tearDown()
    }

    func testViewDidLoadShouldAddCollectionView() {
        // When
        sut.viewDidLoad()

        // Then
        XCTAssertNotNil(sut.view.subviews.first { $0 is UICollectionView })
    }

    func testViewDidLoadShouldLoadData() {
        // Given
        let expectedBreed = "test"
        sut.breedSelected = expectedBreed

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertTrue(spyPresenter.loadDataCalled)
        XCTAssertEqual(spyPresenter.loadDataRequest?.breed, expectedBreed)
    }
    func testDisplayDataShouldSetItems() {
        // Given
        let exp = expectation(description: "displayData DispatchQueue.main.async")
        let expectedItems = ["1", "2", "3"]
        let response = BreedImagesModels.LoadData.Response(items: expectedItems)

        // When
        sut.displayData(response: response)

        // Then
        XCTAssertEqual(sut.items, expectedItems)
        DispatchQueue.main.async {
            XCTAssertTrue(self.spyCollectionView.reloadDataCalled)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)

    }

    func testDisplayErrorShouldPresentAlert() {
        // Given
        let exp = expectation(description: "displayError DispatchQueue.main.async")
        let response = BreedImagesModels.ShowError.Response()

        // When
        sut.displayError(response: response)

        // Then
        DispatchQueue.main.async {
            XCTAssertTrue(self.sut.presentedCalled)
            XCTAssertTrue(self.sut.viewControllerToPresent is UIAlertController)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)
    }

    func testTableViewDidSelectRowAtShouldRouteToBreedImages() {
        // Given
        let exp = expectation(description: "tableViewDidSelectRowAt DispatchQueue.main.async")
        let expectedImages = ["test"]
        let expectedSelected = 0
        let indexPath = IndexPath(row: expectedSelected, section: 0)
        sut.items = expectedImages

        // When
        sut.collectionView(spyCollectionView, didSelectItemAt: indexPath)

        // Then
        DispatchQueue.main.async {
            XCTAssertTrue(self.spyRouter.routeToPreviewImagesCalled)
            XCTAssertEqual(self.spyRouter.routeToBreedImagesImages, expectedImages)
            XCTAssertEqual(self.spyRouter.routeToBreedImagesSelected, expectedSelected)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)
    }

}
