//
//  NewsInteractorInput.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

/// Протокол описывает интерактор новостей
protocol NewsInteractorInput: AnyObject {
    /// Делает запрос новостной ленты
    func fetchNewsFeed()

    /// Делает запрос детальной информации новости
    /// - Parameters:
    ///   - id: Идентификатор новости
    func fetchNewsDetails(with id: String)

    /// Загружает картнику
    /// - Parameters:
    ///   - id: Идентификатор картинки
    ///   - newsId: Идентификатор новости
    func loadImage(id: String, newsId: String)

    /// Загружает картинку
    /// - Parameters:
    ///   - photoId: Идентификатор фотографии
    func loadAdditionalPhoto(with photoId: String)
}
