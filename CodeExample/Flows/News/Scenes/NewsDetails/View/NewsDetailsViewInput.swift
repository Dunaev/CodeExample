//
//  NewsDetailsViewInput.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import SLFoundation
import UIKit

/// Протокол описывает вью подробной информации новости
protocol NewsDetailsViewInput: Presentable {
    /// Показывает индикатор загрузки
    func showLoader()

    /// Показывает сообщение об ошибки
    /// - Parameters:
    ///   - message: Сообщение ошибки
    func showError(message: String)

    /// Показывает контент
    /// - Parameters:
    ///   - viewModel: Вью-модель подробной информации новости
    func showContent(with viewModel: NewsDetailsViewModel)

    /// Обновляет картинку
    /// - Parameters:
    ///   - image: Картинка
    ///   - index: Индекс картинки
    func updateImage(_ image: UIImage, with index: Int)
}
