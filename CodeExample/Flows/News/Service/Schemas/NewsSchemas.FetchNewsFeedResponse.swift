//
//  NewsSchemas.FetchNewsFeedResponse.swift
//  Mesta
//
//  Created by Sergey Dunaev on 22.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import Foundation

extension NewsSchemas {
    /// Схема ответа запроса ленты новостей
    struct FetchNewsFeedResponse: Decodable {
        /// Список новостей
        let newsFeed: [NewsCard]
    }
}

extension NewsSchemas.FetchNewsFeedResponse {
    /// Схема карточки новости
    struct NewsCard: Decodable {
        /// Идентификатор новости
        let id: String
        /// Заголовок новости
        let title: String
        /// Основное фото новости
        let mainPhotoId: String
        /// Дата новости
        let date: Date
        /// Наименование участвующего партнера
        let partnerName: String?
        /// Наименование участвующего партнера
        let partnerLogo: String?
        /// Тэги
        let tags: [String]?
    }
}
