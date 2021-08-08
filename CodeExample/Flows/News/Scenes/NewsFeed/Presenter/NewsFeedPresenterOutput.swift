//
//  NewsFeedPresenterOutput.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

/// Протокол описывает делегата презентера новостной ленты
protocol NewsFeedPresenterOutput: AnyObject {
    /// Запрашивает новостную ленту
    /// - Parameters:
    ///   - presenter: Презентер
    func requestNewsFeed(_ presenter: NewsFeedPresenterInput)

    /// Сообщает о запуске процесса выбора ЖК
    func startResidentialComplexSelection(_ presenter: NewsFeedPresenterInput)

    /// Вызывается при выборе новости
    /// - Parameters:
    ///   - presenter: Презентер
    ///   - id: Идентификатор новости
    func didSelectNews(_ presenter: NewsFeedPresenterInput, with id: String)

    /// Загружает фотографию
    /// - Parameters:
    ///   - presenter: Презентер
    ///   - id: Идентификатор фотографии
    ///   - newsId: Идентификатор новости
    func loadImage(_ presenter: NewsFeedPresenterInput, id: String, newsId: String)
}
