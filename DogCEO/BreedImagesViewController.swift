//
//  BreedImagesViewController.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import UIKit

class BreedImagesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        view.style = .large
        view.color = .black
        return view
    }()
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createViewLayout())
        view.delegate = self
        view.dataSource = self
        view.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .white
        return view
    }()
    let network = NetworkAPI()
    var breedSelected = ""
    var images: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    func setupUI() {
        title = breedSelected.capitalized
        view.addSubview(collectionView)
        collectionView.fillParent()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? ImageCell {
            cell.setupData(url: images[indexPath.row])
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let dest = ImagesPreviewViewController(images: images, selected: indexPath.row)
        navigationController?.pushViewController(dest, animated: true)

    }

    func showLoading() {
        view.addSubview(loadingView)
        loadingView.centerParent()
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
            }
        )
    }

    func loadData() {
        showLoading()
        network.getImagesList(
            breed: breedSelected,
            onSuccess: { [weak self] response in
                if let self = self {
                    self.images = response.images
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

    func createViewLayout() -> UICollectionViewCompositionalLayout {
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
