//
//  NewsDetailsViewController.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import UIKit

/// Вью-контроллер подробной информации новости
final class NewsDetailsViewController: UIViewController {
    override var isNavBarHidden: Bool { true }

    weak var output: NewsDetailsViewOutput?

    private var loadingStatusView: LoadingStatusView?

    private lazy var contentView: NewsDetailsContentView = {
        let contentView = NewsDetailsContentView()

        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        output?.didLoad()
    }

    private func setupView() {
        view.backgroundColor = Token.backgroundMain.color
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension NewsDetailsViewController: NewsDetailsViewInput {
    func showLoader() {
        loadingStatusView?.removeFromSuperview()

        loadingStatusView = LoadingStatusView(status: .loading)
        loadingStatusView?.layout(in: view)

        contentView.isHidden = true
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

        contentView.isHidden = true
    }

    func showContent(with viewModel: NewsDetailsViewModel) {
        loadingStatusView?.removeFromSuperview()

        contentView.isHidden = false
        contentView.updateContent(with: viewModel)
    }

    func updateImage(_ image: UIImage, with index: Int) {
        contentView.updateImage(image, with: index)
    }
}
