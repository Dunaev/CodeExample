//
//  NewsDetailsPresenter.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import UIKit
import SLFoundation

/// Презентер подробной информации новости
final class NewsDetailsPresenter {
    weak var output: NewsDetailsPresenterOutput?

    private let view: NewsDetailsViewInput
    private let newsId: String

    private var photoMap: [String: Int] = [:]

    /// Инициализирует презентер подробной информации новости
    /// - Parameters:
    ///   - view: Вью
    ///   - newsId: Индентификатор новости
    init(view: NewsDetailsViewInput, newsId: String) {
        self.view = view
        self.newsId = newsId
    }
}

extension NewsDetailsPresenter: NewsDetailsPresenterInput {
    func presentContent(model: NewsModel) {
        let photoIds = model.additionalPhotoIds ?? []
        photoMap = [:]
        var photos: [UIImage] = []

        for (index, photoId) in photoIds.enumerated() {
            photoMap[photoId] = index
            photos.append(UIImage(named: "placeHolder")!)
            output?.loadImage(self, with: photoId)
        }

        let viewModel = NewsDetailsViewModel(
            photos: photos,
            date: formattedDate(model.date),
            title: model.title,
            partnerLogo: ImageLoader.image(from: model.partnerLogo),
            partnerName: model.partnerName,
            partnerAddress: model.address,
            content: model.content
        )
        view.showContent(with: viewModel)
    }

    func presentError(with error: UniversalSenderError) {
        view.showError(message: "Не удалось загрузить данные")
    }

    func updateImage(data: Data?, photoId: String) {
        guard let index = photoMap[photoId],
              let data = data,
              let image = UIImage(data: data)
        else { return }
        view.updateImage(image, with: index)
    }

    private func formattedDate(_ date: Date) -> String {
        guard !date.hasSame([.day, .month, .year], as: Date()) else {
            return "Сегодня"
        }
        return date.format("dd MMM")
    }
}

extension NewsDetailsPresenter: NewsDetailsViewOutput {
    func didLoad() {
        fetchContent()
    }

    func fetchContent() {
        view.showLoader()
        output?.requestNewsDetails(self, id: newsId)
    }
}
