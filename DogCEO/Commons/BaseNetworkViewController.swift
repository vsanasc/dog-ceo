//
//  BaseNetworkViewController.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import UIKit

class BaseNetworkViewController: UIViewController {

    private let loadingView = LoadingView(frame: .zero)
    let network = NetworkAPI()
    var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    func setupUI() {
        title = "Dog CEO"
    }
    func showLoading() {
        view.addSubview(loadingView)
        loadingView.fillParent()
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.loadingView.alpha = 1
            }
        )
    }
    func hideLoading() {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.loadingView.alpha = 0
            },
            completion: { _ in
                self.loadingView.removeFromSuperview()
            }
        )
    }
    func loadData() {
        showLoading()
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
