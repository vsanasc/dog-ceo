//
//  LoadingView.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import UIKit

class LoadingView: UIView {

    private lazy var label: UILabel = {
        let view = UILabel()
        view.text = "cargando..."
        view.font = .systemFont(ofSize: 16.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        view.style = .large
        view.color = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubviews() {
        addSubview(activityView)
        addSubview(label)
    }
    private func setupConstraints() {
        activityView.centerParent()
        let constraints: [NSLayoutConstraint] = [
            label.topAnchor.constraint(equalTo: activityView.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: activityView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
