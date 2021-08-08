//
//  NewsService.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import Foundation
import SLFoundation

/// Сервис новостей
final class NewsService {
    private let sender: UniversalSenderProtocol

    /// Инициализирует сервис новостей
    /// - Parameters:
    ///   - sender: Универсальный отправитель запросов
    init(sender: UniversalSenderProtocol) {
        self.sender = sender
    }
}

extension NewsService: NewsServiceInput {
    func fetchNewsFeed(
        residentialComplexId: String,
        completion: @escaping (Result<[NewsCardModel], UniversalSenderError>) -> Void
    ) {
        let requestSchema = NewsSchemas.FetchNewsFeedRequest(residentialComplexId: residentialComplexId)

        let senderCompletion: (
            Result<NewsSchemas.FetchNewsFeedResponse, UniversalSenderError>
        ) -> Void = { result in
            switch result {
            case .success(let responseSchema):
                let model = responseSchema.newsFeed.map {
                    NewsCardModel(schema: $0)
                }
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

        sender.post(
            endpoint: Endpoint.fetchNewsFeed,
            requestSchema: requestSchema,
            completion: senderCompletion
        )
    }

    func fetchNewsDetails(
        newsId: String,
        completion: @escaping (Result<NewsModel, UniversalSenderError>) -> Void
    ) {
        let requestSchema = NewsSchemas.FetchNewsDetailsRequest(newsId: newsId)

        let senderCompletion: (
            Result<NewsSchemas.FetchNewsDetailsResponse, UniversalSenderError>
        ) -> Void = { result in
            switch result {
            case .success(let responseSchema):
                let model = NewsModel(schema: responseSchema)
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

        sender.post(
            endpoint: Endpoint.fetchNewsDetails,
            requestSchema: requestSchema,
            completion: senderCompletion
        )
    }
}

extension NewsService {
    private enum Endpoint {
        static let fetchNewsFeed = "/mesta/fetchNewsFeed"
        static let fetchNewsDetails = "/mesta/fetchNewsDetails"
    }
}
