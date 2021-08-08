//
//  NewsFeedViewInput.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import SLFoundation

/// Протокол описвает вью новостной ленты
protocol NewsFeedViewInput: Presentable {
    /// Показывает индикатор загрузки
    func showLoader()

    /// Показывает ошибку
    /// - Parameters:
    ///   - message: Сообщение ошибки
    func showError(message: String)

    /// Показывает контент
    /// - Parameters:
    ///   - sectionViewModels: Вью-модели
    func showContent(sectionViewModels: [UniversalTableSectionViewModel])

    /// Обновляет контент секции
    /// - Parameters:
    ///   - section: Вью-модель секции
    func updateContentSection(with section: UniversalTableSectionViewModel)
}
