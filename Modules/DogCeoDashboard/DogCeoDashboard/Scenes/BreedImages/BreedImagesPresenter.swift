//
//  BreedImagesPresenter.swift
//  DogCeoDashboard
//
//  Created by Vitor on 04-04-21.
//

protocol BreedImagesPresenterProtocol {
    var output: BreedImagesPresenterOutput? { get set }
    var worker: BreedImagesWorkerProtocol? { get set }

    func loadData(request: BreedImagesModels.LoadData.Request)

}

protocol BreedImagesPresenterOutput {
    func displayData(response: BreedImagesModels.LoadData.Response)
    func displayError(response: BreedImagesModels.ShowError.Response)
}

class BreedImagesPresenter: BreedImagesPresenterProtocol {
    var output: BreedImagesPresenterOutput?
    var worker: BreedImagesWorkerProtocol?

    func loadData(request: BreedImagesModels.LoadData.Request) {

        worker?.getList(
            breed: request.breed,
            onSuccess: { [weak self] response in
                self?.output?.displayData(
                    response: .init(items: response.images)
                )
            },
            onError: { [weak self] _ in
                self?.output?.displayError(
                    response: .init()
                )
            }
        )
    }
}

