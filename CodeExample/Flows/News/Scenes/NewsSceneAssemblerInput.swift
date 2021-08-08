//
//  NewsSceneAssemblerInput.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import SLFoundation

/// Протокол описывает сборщик ссцен новостей
protocol NewsSceneAssemblerInput {
    /// Создает сцену новостной ленты
    /// - Returns: Сцена новостной ленты
    func makeNewsFeedScene() -> Scene<NewsFeedPresenterInput>

    /// Создает сцену подробной информации новости
    /// - Parameters:
    ///   - id: Идентификатор новости
    /// - Returns: Сцена подробной информации новости
    func makeNewsDetailsScene(with id: String) -> Scene<NewsDetailsPresenterInput>
}
