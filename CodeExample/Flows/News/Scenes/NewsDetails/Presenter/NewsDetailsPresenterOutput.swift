//
//  NewsDetailsPresenterOutput.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

/// Протокол описывает делегат презентера подробной информации новости
protocol NewsDetailsPresenterOutput: AnyObject {
    /// Вызывается при запросе подробной информации новости
    /// - Parameters:
    ///   - presenter: презентер
    ///   - id: Идентификатор новости
    func requestNewsDetails(_ presenter: NewsDetailsPresenterInput, id: String)

    /// Вызывается при загрузке картинки
    /// - Parameters:
    ///   - presenter: Презентер
    ///   - photoId: Идентификатор фотографии
    func loadImage(_ presenter: NewsDetailsPresenterInput, with photoId: String)
}
