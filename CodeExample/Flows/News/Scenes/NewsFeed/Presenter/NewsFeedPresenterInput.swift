//
//  NewsFeedPresenterInput.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import Foundation
import SLFoundation

/// Протокол описывает презентер новостной ленты
protocol NewsFeedPresenterInput: AnyObject {
    /// Делегат
    var output: NewsFeedPresenterOutput? { get set }

    /// Показывает контент
    /// - Parameters:
    ///   - residentialComplexName: Название ЖК
    ///   - models: Модель данных
    func presentContent(residentialComplexName: String, models: [NewsCardModel])

    /// Показывает ошибку
    /// - Parameters:
    ///   - error: Ошибка
    func presentError(with error: UniversalSenderError)

    /// Обновляет контент
    func updateContent()

    /// Обновляет картинку
    /// - Parameters:
    ///   - data: Двоичные данные
    ///   - newsId: Идентификатор новости
    func updateImage(data: Data?, newsId: String)
}
