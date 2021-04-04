//
//  BreedImagesViewController.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import DogCeoCommons
import DogCeoUIKit

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
    private let network: WorkerAPI
    private let breedSelected: String

    init(network: WorkerAPI, breedSelected: String) {
        self.network = network
        self.breedSelected = breedSelected
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.setCollectionViewLayout(createViewLayout(), animated: true)
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
            onError: { _ in
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
        let count = UIDevice.current.orientation.isLandscape ? 4 : 2
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(2/6)),
            subitem: item,
            count: count
        )
        let section = NSCollectionLayoutSection(group: group)

        return .init(section: section)
    }

}
