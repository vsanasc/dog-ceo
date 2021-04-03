//
//  BreedImagesViewController.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import UIKit

class BreedImagesViewController: BaseNetworkViewController,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createViewLayout())
        view.delegate = self
        view.dataSource = self
        view.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .white
        return view
    }()
    private var breedSelected = ""

    convenience init(breedSelected: String) {
        self.init()
        self.breedSelected = breedSelected
    }

    override func setupUI() {
        super.setupUI()
        title = breedSelected.capitalized
        view.addSubview(collectionView)
        collectionView.fillParent()
    }
    override func loadData() {
        super.loadData()
        network.getImagesList(
            breed: breedSelected,
            onSuccess: { [weak self] response in
                if let self = self {
                    self.items = response.images
                    DispatchQueue.main.async {
                        self.hideLoading()
                        self.collectionView.reloadData()
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? ImageCell {
            cell.setupData(url: items[indexPath.row])
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let dest = ImagesPreviewViewController(images: items, selected: indexPath.row)
        navigationController?.pushViewController(dest, animated: true)

    }
    private func createViewLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(2/6)),
            subitem: item,
            count: 2
        )
        let section = NSCollectionLayoutSection(group: group)

        return .init(section: section)
    }
    

}
