//
//  BreedListViewControllerSpy.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

@testable import DogCeoDashboard

class BreedImagesViewControllerSpy: BreedImagesViewController {

    // MARK: - Spy Response
    private(set) var displayDataResponse: BreedImagesModels.LoadData.Response?
    private(set) var displayErrorResponse: BreedImagesModels.ShowError.Response?

    // MARK: - Called Properties
    private(set) var displayDataCalled = false
    private(set) var displayErrorCalled = false

    // MARK: - Methods
    override func displayData(response: BreedImagesModels.LoadData.Response) {
        displayDataCalled = true
        displayDataResponse = response
    }
    override func displayError(response: BreedImagesModels.ShowError.Response) {
        displayErrorCalled = true
        displayErrorResponse = response
    }
}

extension BreedImagesViewController {
    
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
