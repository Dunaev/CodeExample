//
//  NewsFeedViewController.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import UIKit

/// Вью-контроллер новостной ленты
final class NewsFeedViewController: UIViewController {
    weak var output: NewsFeedViewOutput?

    override var isNavBarHidden: Bool { true }

    private var loadingStatusView: LoadingStatusView?

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = UIColor.DesignSystemPalette.white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)

        return collectionView
    }()

    private lazy var collectionDataController: UniversalCollectionViewDataController = {
        let collectionDataController = UniversalCollectionViewDataController()
        collectionDataController.collectionView = collectionView

        return collectionDataController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        output?.didLoad()
    }

    private func setupView() {
        let backgroundAtom = BackgroundAtom(colorToken: .backgroundMain)
        view.addSubview(backgroundAtom)
        backgroundAtom.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            case 0:
                return self.createHeaderSection()
            default:
                return self.createMainSection()
            }
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 32
        layout.configuration = configuration

        return layout
    }

    private func createHeaderSection() -> NSCollectionLayoutSection {
        let headerItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(36)
        )
        let headerItem = NSCollectionLayoutItem(layoutSize: headerItemSize)

        let headerGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: headerItemSize,
            subitems: [headerItem]
        )
        let section = NSCollectionLayoutSection(group: headerGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)

        return section
    }

    private func createMainSection() -> NSCollectionLayoutSection {
        let topItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(150)
        )
        let topItem = NSCollectionLayoutItem(layoutSize: topItemSize)

        let secondaryItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(100)
        )
        let secondaryItem = NSCollectionLayoutItem(layoutSize: secondaryItemSize)
        let secondaryGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: secondaryItemSize,
            subitem: secondaryItem,
            count: 2
        )
        secondaryGroup.interItemSpacing = .fixed(16)

        let mainGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(100)
        )
        let mainGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: mainGroupSize,
            subitems: [topItem, secondaryGroup, secondaryGroup, secondaryGroup]
        )
        mainGroup.interItemSpacing = .fixed(32)

        let section = NSCollectionLayoutSection(group: mainGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = 32

        return section
    }
}

extension NewsFeedViewController: NewsFeedViewInput {
    func showLoader() {
        loadingStatusView?.removeFromSuperview()

        loadingStatusView = LoadingStatusView(status: .loading)
        loadingStatusView?.layout(in: view)

        collectionView.isHidden = true
    }

    func showError(message: String) {
        loadingStatusView?.removeFromSuperview()

        loadingStatusView = LoadingStatusView(
            status: .error(title: message, subtitle: nil, buttonTitle: "Обновить")
        )
        loadingStatusView?.onErrorViewButtonTap = { [weak self] in
            self?.output?.fetchContent()
        }
        loadingStatusView?.layout(in: view)

        collectionView.isHidden = true
    }

    func showContent(sectionViewModels: [UniversalTableSectionViewModel]) {
        loadingStatusView?.removeFromSuperview()

        collectionView.isHidden = false
        collectionDataController.reset(sections: sectionViewModels)
    }

    func updateContentSection(with section: UniversalTableSectionViewModel) {
        collectionDataController.updateSection(with: section, at: 1)
    }
}
