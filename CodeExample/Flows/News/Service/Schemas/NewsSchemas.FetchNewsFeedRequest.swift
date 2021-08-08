//
//  NewsSchemas.FetchNewsFeedRequest.swift
//  Mesta
//
//  Created by Sergey Dunaev on 22.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

extension NewsSchemas {
    /// Схема запроса ленты новостей
    struct FetchNewsFeedRequest: Encodable {
        /// Идентификатор ЖК
        let residentialComplexId: String
    }
}
