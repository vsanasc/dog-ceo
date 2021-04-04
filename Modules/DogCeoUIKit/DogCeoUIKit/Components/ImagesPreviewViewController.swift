//
//  ImagesPreviewViewController.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import DogCeoCommons
import UIKit

open class ImagesPreviewViewController: UIViewController,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = .zero
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.dataSource = self
        view.delegate = self
        view.isPagingEnabled = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.register(ImagePreviewCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .darkGray
        view.clipsToBounds = true
        return view
    }()
    private var images: [String] = []
    private var selected: Int = 0

    public convenience init(images: [String], selected: Int) {
        self.init()
        self.images = images
        self.selected = selected
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        collectionView.reloadData()
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        collectionView.contentOffset.x = CGFloat(selected) * view.frame.size.width
    }
    func setupUI() {
        setTitle(position: selected)
        view.addSubview(collectionView)
        collectionView.fillParent()
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let height = view.frame.height
        let insets = view.safeAreaInsets.top + view.safeAreaInsets.bottom
        let safeHeight = height - insets
        return .init(
            width: view.frame.width,
            height: safeHeight
        )

    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? ImagePreviewCell {
            cell.setupData(url: images[indexPath.row])
        }
        return cell
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            let scrollX = self.collectionView.contentOffset.x
            let width = self.view.frame.width
            let item = scrollX / width
            let position = Int(item)
            self.setTitle(position: position)
        }
    }

    private func setTitle(position: Int) {
        title = "Item \(position + 1) of \(images.count)"
    }

}
