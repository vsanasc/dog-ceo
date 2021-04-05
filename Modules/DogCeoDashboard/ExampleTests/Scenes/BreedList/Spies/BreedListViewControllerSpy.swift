//
//  BreedListViewControllerSpy.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

@testable import DogCeoDashboard

class BreedListViewControllerSpy: BreedListViewController {

    // MARK: - Spy Response
    private(set) var displayDataResponse: BreedListModels.LoadData.Response?
    private(set) var displayErrorResponse: BreedListModels.ShowError.Response?

    // MARK: - Called Properties
    private(set) var displayDataCalled = false
    private(set) var displayErrorCalled = false

    // MARK: - Methods
    override func displayData(response: BreedListModels.LoadData.Response) {
        displayDataCalled = true
        displayDataResponse = response
    }
    override func displayError(response: BreedListModels.ShowError.Response) {
        displayErrorCalled = true
        displayErrorResponse = response
    }
}

extension BreedListViewController {
    
    enum Holder {
        static var _presentedCalled: Bool = false
        static var _viewControllerToPresent: UIViewController = UIViewController()
    }

    var presentedCalled: Bool {
        get {
            Holder._presentedCalled
        }
        set {
            Holder._presentedCalled = newValue
        }
    }
    var viewControllerToPresent: UIViewController {
        get {
            Holder._viewControllerToPresent
        }
        set {
            Holder._viewControllerToPresent = newValue
        }
    }

    override open func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)? = nil
    ) {
        Holder._presentedCalled = true
        Holder._viewControllerToPresent = viewControllerToPresent
    }
}
