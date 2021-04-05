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
UICollectionViewDelegateFlowLayout,
BreedImagesPresenterOutput {

    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createViewLayout())
        view.delegate = self
        view.dataSource = self
        view.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .white
        return view
    }()
    var router: BreedImagesRouterProtocol?
    var presenter: BreedImagesPresenterProtocol?

    var breedSelected: String = ""

    init(managerAPI: ManagerRequestAPI) {
        super.init(nibName: nil, bundle: nil)
        let router = BreedImagesRouter()
        let presenter = BreedImagesPresenter()
        let worker = BreedImagesWorker(manager: managerAPI)

        router.viewController = self
        presenter.output = self
        presenter.worker = worker

        self.presenter = presenter
        self.router = router
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
        presenter?.loadData(request: .init(breed: breedSelected))
    }
    // MARK: - BreedImagesPresenterOutput
    func displayData(response: BreedImagesModels.LoadData.Response) {
        items = response.items
        DispatchQueue.main.async {
            self.hideLoading()
            self.collectionView.reloadData()
        }

    }
    func displayError(response: BreedImagesModels.ShowError.Response) {
        DispatchQueue.main.async {
            self.hideLoading()
            self.showErrorMessage()
        }
    }
    // MARK: - UICollectionViewDataSource
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
        router?.routeToPreviewImages(images: items, selected: indexPath.row)
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
