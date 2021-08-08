//
//  NewsCardModel.swift
//  Mesta
//
//  Created by Sergey Dunaev on 22.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import Foundation

/// Модель карточки новости
struct NewsCardModel {
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
    /// Логотип партнера в формате BASE64
    let partnerLogo: String?
    /// Тэги
    let tags: [String]
}

extension NewsCardModel {
    /// Инициализирует модель карточки новости
    /// - Parameters:
    ///   - schema: Схема
    init(schema: NewsSchemas.FetchNewsFeedResponse.NewsCard) {
        id = schema.id
        title = schema.title
        mainPhotoId = schema.mainPhotoId
        date = schema.date
        partnerName = schema.partnerName
        partnerLogo = schema.partnerLogo
        tags = schema.tags ?? []
    }
}
