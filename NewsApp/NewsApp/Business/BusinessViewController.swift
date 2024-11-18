//
//  BusinessViewController.swift
//  NewsApp
//
//  Created by Elizaveta Potapova on 11/10/24.
//



import UIKit
import SnapKit

class BusinessViewController: UIViewController {

    // MARK: - GUI Variables

    private var viewModel: BusinessViewModelProtocol

    init(viewModel: BusinessViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        collectionView.register(GeneralCollectionViewCell.self, forCellWithReuseIdentifier: "GeneralCollectionViewCell")

        collectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        setUpUI()
        self.bindViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()


        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setUPConstraints()
    }


    // MARK: Methods

    // MARK: Private methods
    private func setUpUI() {
        view.backgroundColor = .white

        view.addSubview(collectionView)

        setUPConstraints()

    }

    private func setUPConstraints() {

        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func bindViewModel() {
        viewModel.reloadData = { [weak self ] in
            print("Reloading collection view")
            self?.collectionView.reloadData()
        }
        viewModel.showError = { [weak self] errorMessage in
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
}


extension BusinessViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfCells > 1 ? 2 : 1
    }



    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard viewModel.numberOfCells > 0 else { return 0 }
        return section == 0 ? 1 : viewModel.numberOfCells - 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard viewModel.numberOfCells > 0 else { return UICollectionViewCell() }
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell", for: indexPath) as? GeneralCollectionViewCell {
                let article = viewModel.getArticle(for: 0)
                cell.configure(with: article)
                return cell
            }
        } else {
            guard indexPath.row < viewModel.numberOfCells - 1 else { return UICollectionViewCell() }
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as? DetailsCollectionViewCell {
                let article = viewModel.getArticle(for: indexPath.row + 1)
                cell.configure(with: article)
                return cell
            }
        }
        return UICollectionViewCell()
    }



}

// MARK: - UICollectionViewDelegate
extension BusinessViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 0 || indexPath.row + 1 < viewModel.numberOfCells else { return }
        let article = viewModel.getArticle(for: indexPath.section == 0 ? 0 : indexPath.row + 1)
        navigationController?.pushViewController(NewsViewController(viewModel: NewsViewModel(article: article)), animated: true)

    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension BusinessViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let firstSectionItemSize = CGSize(width: width, height: width)
        let secondSectionItemSize = CGSize(width: width, height: 100)

        return indexPath.section == 0 ? firstSectionItemSize : secondSectionItemSize
    }
}
