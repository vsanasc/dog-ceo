//
//  BreedListPresenter.swift
//  DogCeoDashboard
//
//  Created by Vitor on 04-04-21.
//

protocol BreedListPresenterProtocol {
    var output: BreedListPresenterOutput? { get set }
    var worker: BreedListWorkerProtocol? { get set }

    func loadData()
    
}

protocol BreedListPresenterOutput {
    func displayData(response: BreedListModels.LoadData.Response)
    func displayError(response: BreedListModels.ShowError.Response)
}

class BreedListPresenter: BreedListPresenterProtocol {
    var output: BreedListPresenterOutput?
    var worker: BreedListWorkerProtocol?

    func loadData() {

        worker?.getList(
            onSuccess: { [weak self] response in
                self?.output?.displayData(
                    response: .init(items: response.items)
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
