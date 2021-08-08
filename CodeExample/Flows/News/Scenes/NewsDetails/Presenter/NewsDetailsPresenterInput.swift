//
//  NewsDetailsPresenterInput.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import SLFoundation
import Foundation

/// Протоколо описывает презентер подробной информации новости
protocol NewsDetailsPresenterInput: AnyObject {
    /// Делегат
    var output: NewsDetailsPresenterOutput? { get set }

    /// Показывает контент новости
    /// - Parameters:
    ///   - model: Модель новости
    func presentContent(model: NewsModel)

    /// Показывает ошибку
    /// - Parameters:
    ///   - error: Ошибка
    func presentError(with error: UniversalSenderError)

    /// Обновляет картинку
    /// - Parameters:
    ///   - data: Двоичные данные
    ///   - photoId: Идентификатор фотографии
    func updateImage(data: Data?, photoId: String)
}
