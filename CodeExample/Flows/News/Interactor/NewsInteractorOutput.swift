//
//  NewsInteractorOutput.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import Foundation
import SLFoundation

/// Протокол описывает делегат интерактора новостей
protocol NewsInteractorOutput: AnyObject {
    /// Вызывается при получении новостной ленты
    /// - Parameters:
    ///   - residentialComplexName: Название ЖК
    ///   - models: Модели новостей
    func didReceiveNewsFeed(residentialComplexName: String, models: [NewsCardModel])

    /// Вызывается при получении ошибки запроса новостной ленты
    /// - Parameters:
    ///   - error: Ошибка
    func didReceiveNewsFeedError(error: UniversalSenderError)

    /// Вызывается при получении подробной информации новости
    /// - Parameters:
    ///   - model: Модель новости
    func didReceiveNewsDetails(model: NewsModel)

    /// Вызывается при получении ошибки запроса подробной информации новости
    /// - Parameters:
    ///   - error: Ошибка
    func didReceiveNewsDetailsError(error: UniversalSenderError)

    /// Вызывается при получении картинки
    /// - Parameters:
    ///   - data: Двоичные данные
    ///   - newsId: Идентификатор новости
    func didReceiveImage(data: Data?, newsId: String)

    /// Вызывается при получении дополнительной фотографии
    /// - Parameters:
    ///   - data: Двоичные данные
    ///   - photoId: Идентификатор фотографии
    func didReceiveAdditionalPhoto(data: Data?, photoId: String)
}
