//
//  BreedListViewController.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import DogCeoCommons
import DogCeoUIKit

class BreedListViewController: BaseNetworkViewController, UITableViewDelegate, UITableViewDataSource {

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        return view
    }()

    private let network: WorkerAPI

    init(manager: ManagerRequestAPI) {
        self.network = WorkerAPI(manager: manager)
        super.init(nibName: nil, bundle: nil)
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
        network.getBreedsList(
            onSuccess: { [weak self] response in
                if let self = self {
                    self.items = response.items
                    DispatchQueue.main.async {
                        self.hideLoading()
                        self.tableView.reloadData()
                    }
                }
            },
            onError: { _ in
                DispatchQueue.main.async {
                    self.showErrorMessage()
                }
            }
        )
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
        let dest = BreedImagesViewController(network: network, breedSelected: items[indexPath.row])
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(dest, animated: true)
        }

    }

}
