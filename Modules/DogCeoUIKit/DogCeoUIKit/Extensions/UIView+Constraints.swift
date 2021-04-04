//
//  UIView+Constraints.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import UIKit

public extension UIView {

    func fillParentMargin(top: CGFloat, trailing: CGFloat, leading: CGFloat, bottom: CGFloat) {
        guard let parent = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            topAnchor.constraint(equalTo: parent.topAnchor, constant: top),
            bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -bottom),
            trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -trailing),
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: leading)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func fillParent(margin: CGFloat = 0) {
        fillParentMargin(top: margin, trailing: margin, leading: margin, bottom: margin)
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
