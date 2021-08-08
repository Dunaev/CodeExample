//
//  NewsServiceInput.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import SLFoundation

/// Протокол описывает сервис новостей
protocol NewsServiceInput {
    /// Делает запрос ленты новостей
    /// - Parameters:
    ///   - residentialComplexId: Идентфикатор ЖК
    ///   - completion: Обрботчик ответа запроса
    func fetchNewsFeed(
        residentialComplexId: String,
        completion: @escaping (Result<[NewsCardModel], UniversalSenderError>) -> Void
    )

    /// Делает запрос получения подробной информации новости
    /// - Parameters:
    ///   - newsId: Идентфикатор новости
    ///   - completion: Обработчик ответа запроса
    func fetchNewsDetails(
        newsId: String,
        completion: @escaping (Result<NewsModel, UniversalSenderError>) -> Void
    )
}
