//
//  NewsSchemas.FetchNewsDetailsResponse.swift
//  Mesta
//
//  Created by Sergey Dunaev on 13.06.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import Foundation

extension NewsSchemas {
    /// Схема ответа запроса подробной информации новости
    struct FetchNewsDetailsResponse: Decodable {
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
}
