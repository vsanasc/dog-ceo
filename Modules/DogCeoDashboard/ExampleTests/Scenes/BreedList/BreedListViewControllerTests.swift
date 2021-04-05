//
//  BreedListViewControllerTests.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

@testable import DogCeoDashboard
import XCTest

class BreedListViewControllerTests: XCTestCase {

    var sut: BreedListViewController!
    var spyManagerAPI: MockManagerRequestAPI!
    var spyPresenter: BreedListPresenterSpy!
    var spyRouter: BreedListRouterSpy!
    var spyTableView: TableViewSpy!

    override func setUp() {
        super.setUp()
        spyRouter = .init()
        spyTableView = .init()
        spyPresenter = .init()
        spyManagerAPI = .init()

        sut = .init(manager: spyManagerAPI)
        sut.tableView = spyTableView
        sut.presenter = spyPresenter
        sut.router = spyRouter
    }
    override func tearDown() {
        spyRouter = nil
        spyTableView = nil
        spyPresenter = nil
        spyManagerAPI = nil
        sut = nil
        super.tearDown()
    }

    func testViewDidLoadShouldAddTableView() {
        // When
        sut.viewDidLoad()

        // Then
        XCTAssertNotNil(sut.view.subviews.first { $0 is UITableView })
    }

    func testViewDidLoadShouldLoadData() {
        // When
        sut.viewDidLoad()

        // Then
        XCTAssertTrue(spyPresenter.loadDataCalled)
    }
    func testDisplayDataShouldSetItems() {
        // Given
        let exp = expectation(description: "displayData DispatchQueue.main.async")
        let expectedItems = ["1", "2", "3"]
        let response = BreedListModels.LoadData.Response(items: expectedItems)

        // When
        sut.displayData(response: response)

        // Then
        XCTAssertEqual(sut.items, expectedItems)
        DispatchQueue.main.async {
            XCTAssertTrue(self.spyTableView.reloadDataCalled)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)

    }

    func testDisplayErrorShouldPresentAlert() {
        // Given
        let exp = expectation(description: "displayError DispatchQueue.main.async")
        let response = BreedListModels.ShowError.Response()

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
        let expectedBreed = "test"
        let indexPath = IndexPath(row: 0, section: 0)
        sut.items = [expectedBreed]

        // When
        sut.tableView(spyTableView, didSelectRowAt: indexPath)

        // Then
        DispatchQueue.main.async {
            XCTAssertTrue(self.spyRouter.routeToBreedImagesCalled)
            XCTAssertEqual(self.spyRouter.routeToBreedImagesBreed, expectedBreed)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)
    }

}
