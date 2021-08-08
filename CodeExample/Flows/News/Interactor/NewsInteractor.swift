//
//  NewsInteractor.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

/// Интерактор новостей
final class NewsInteractor {
    weak var output: NewsInteractorOutput?

    private let service: NewsServiceInput
    private let imageLoader: ImageLoaderInput
    private let dataManager: GeneralDataManagerInput

    /// Инициализирует интерактор новостеей
    /// - Parameters:
    ///   - service: Сетевой сервис для получения данных
    ///   - imageLoader: Загрузчик картинок
    ///   - dataManager: Менеджер оперативных данных
    init(service: NewsServiceInput, imageLoader: ImageLoaderInput, dataManager: GeneralDataManagerInput) {
        self.service = service
        self.imageLoader = imageLoader
        self.dataManager = dataManager
    }
}

extension NewsInteractor: NewsInteractorInput {
    func fetchNewsFeed() {
        guard let residentialComplexId = dataManager.residentialComplexModel?.id else {
            output?.didReceiveNewsFeedError(error: .emptyResponseContentError)
            return
        }

        service.fetchNewsFeed(residentialComplexId: residentialComplexId) { [weak self] result in
            switch result {
            case .success(let models):
                self?.output?.didReceiveNewsFeed(
                    residentialComplexName: self?.dataManager.residentialComplexModel?.name ?? "-",
                    models: models
                )
            case .failure(let error):
                self?.output?.didReceiveNewsFeedError(error: error)
            }
        }
    }

    func fetchNewsDetails(with id: String) {
        service.fetchNewsDetails(newsId: id) {  [weak self] result in
            switch result {
            case .success(let model):
                self?.output?.didReceiveNewsDetails(model: model)
            case .failure(let error):
                self?.output?.didReceiveNewsDetailsError(error: error)
            }
        }
    }

    func loadImage(id: String, newsId: String) {
        imageLoader.fetchImage(with: id) { [weak self] result in
            switch result {
            case .success(let data):
                self?.output?.didReceiveImage(data: data, newsId: newsId)
            case .failure:
                self?.output?.didReceiveImage(data: nil, newsId: newsId)
            }
        }
    }

    func loadAdditionalPhoto(with photoId: String) {
        imageLoader.fetchImage(with: photoId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.output?.didReceiveAdditionalPhoto(data: data, photoId: photoId)
            case .failure:
                self?.output?.didReceiveAdditionalPhoto(data: nil, photoId: photoId)
            }
        }
    }
}
