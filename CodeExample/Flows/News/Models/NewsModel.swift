//
//  NewsModel.swift
//  Mesta
//
//  Created by Sergey Dunaev on 13.06.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import Foundation

/// Модель новости
struct NewsModel {
    /// Идентификатор новости
    let id: String
    /// Заголовок новости
    let title: String
    /// Содержание новости
    let content: String
    /// Идентификаторы дополнительных фото новости
    let additionalPhotoIds: [String]?
    /// Дата новости
    let date: Date
    /// Адрес
    let address: String?
    /// Идентификатор участвующего партнера
    let partnerId: String?
    /// Наименование участвующего партнера
    let partnerName: String?
    /// Логотип партнера в формате BASE64
    let partnerLogo: String?
}

extension NewsModel {
    /// Инициализирует модель новости
    /// - Parameters:
    ///   - schema: Схема
    init(schema: NewsSchemas.FetchNewsDetailsResponse) {
        id = schema.id
        title = schema.title
        content = schema.content
        additionalPhotoIds = schema.additionalPhotoIds
        date = schema.date
        address = schema.address
        partnerId = schema.partnerId
        partnerName = schema.partnerName
        partnerLogo = schema.partnerLogo
    }
}
