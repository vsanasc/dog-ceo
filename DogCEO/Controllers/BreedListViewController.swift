//
//  BreedListViewController.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import UIKit

class BreedListViewController: UITableViewController {

    lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        view.style = .large
        view.color = .black
        return view
    }()

    let network = NetworkAPI()
    var items: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    func setupUI() {
        title = "Dog CEO"
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row].capitalized
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dest = BreedImagesViewController()
        dest.breedSelected = items[indexPath.row]
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(dest, animated: true)
        }

    }

    func showLoading() {
        view.addSubview(loadingView)
        loadingView.centerParent()
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.loadingView.alpha = 1
                self.tableView.separatorStyle = .none
            }
        )
    }
    func hideLoading() {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.loadingView.alpha = 0
                self.tableView.separatorStyle = .singleLine
            }
        )
    }

    func loadData() {
        showLoading()
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
            onError: { error in
                DispatchQueue.main.async {
                    self.showErrorMessage()
                }
            }
        )
    }

    func showErrorMessage() {
        let alert = UIAlertController(
            title: "Error de Servicio",
            message: "The service isn't available",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "Retry",
                style: .default,
                handler: { action in
                    self.loadData()
                }
            )
        )
        present(alert, animated: true)
    }

}
