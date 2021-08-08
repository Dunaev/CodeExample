//
//  NewsSchemas.FetchNewsDetailsRequest.swift
//  Mesta
//
//  Created by Sergey Dunaev on 13.06.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

extension NewsSchemas {
    /// Схема запроса подробной информации новости
    struct FetchNewsDetailsRequest: Encodable {
        /// Идентификатор новости
        let newsId: String
    }
}
