//
//  ImagePreviewCell.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import UIKit

class ImagePreviewCell: UICollectionViewCell {

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        addSubview(imageView)
        imageView.fillParent()
    }

    func setupData(url: String) {
        imageView.loadImage(fromURL: url, placeholder: UIImage(named: "placeholder"))
    }

}
