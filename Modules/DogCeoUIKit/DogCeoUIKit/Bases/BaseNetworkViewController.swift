//
//  BaseNetworkViewController.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import UIKit

open class BaseNetworkViewController: UIViewController {

    private let loadingView = LoadingView(frame: .zero)
    open var items: [String] = []

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    open func setupUI() {
        title = "Dog CEO"
    }
    open func showLoading() {
        view.addSubview(loadingView)
        loadingView.fillParent()
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.loadingView.alpha = 1
            }
        )
    }
    open func hideLoading() {
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
    open func loadData() {
        showLoading()
    }

    open func showErrorMessage() {
        let alert = UIAlertController(
            title: "Error de Servicio",
            message: "The service isn't available",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "Retry",
                style: .default,
                handler: { _ in
                    self.loadData()
                }
            )
        )
        present(alert, animated: true)
    }
}
