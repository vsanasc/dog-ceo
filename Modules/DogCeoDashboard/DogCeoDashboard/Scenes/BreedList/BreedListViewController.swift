//
//  BreedListViewController.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import DogCeoCommons
import DogCeoUIKit

class BreedListViewController: BaseNetworkViewController,
UITableViewDelegate,
UITableViewDataSource,
BreedListPresenterOutput {

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        return view
    }()

    private var router: BreedListRouterProtocol?
    private var presenter: BreedListPresenterProtocol?

    var manager: ManagerRequestAPI?

    init(manager: ManagerRequestAPI) {
        super.init(nibName: nil, bundle: nil)

        let router = BreedListRouter()
        let presenter = BreedListPresenter()
        let worker = BreedListWorker(manager: manager)

        router.viewController = self
        router.managerAPI = manager
        presenter.output = self
        presenter.worker = worker

        self.presenter = presenter
        self.router = router
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupUI() {
        super.setupUI()
        view.addSubview(tableView)
        tableView.fillParent()
    }
    override func loadData() {
        super.loadData()
        presenter?.loadData()
    }

    // MARK: - BreedListPresenterOutput
    func displayData(response: BreedListModels.LoadData.Response) {
        items = response.items
        DispatchQueue.main.async {
            self.hideLoading()
            self.tableView.reloadData()
        }

    }
    func displayError(response: BreedListModels.ShowError.Response) {
        DispatchQueue.main.async {
            self.hideLoading()
            self.showErrorMessage()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row].capitalized
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.routeToBreedImages(breed: items[indexPath.row])
    }

}
