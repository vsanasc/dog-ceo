//
//  UIView+Constraints.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import UIKit

extension UIView {

    func fillParent(margin: CGFloat = 0) {
        guard let parent = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            topAnchor.constraint(equalTo: parent.topAnchor, constant: margin),
            bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: margin),
            trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: margin),
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: margin)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func centerParent() {
        guard let parent = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            centerYAnchor.constraint(equalTo: parent.centerYAnchor),
            centerXAnchor.constraint(equalTo: parent.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
