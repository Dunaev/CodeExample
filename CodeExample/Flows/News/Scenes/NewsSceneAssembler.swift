//
//  NewsSceneAssembler.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import SLFoundation

/// Сборщик сцен новостей
final class NewsSceneAssembler: NewsSceneAssemblerInput {
    func makeNewsFeedScene() -> Scene<NewsFeedPresenterInput> {
        let view = NewsFeedViewController()
        let presenter = NewsFeedPresenter(view: view)
        view.output = presenter

        return Scene(presenter: presenter, view: view)
    }

    func makeNewsDetailsScene(with id: String) -> Scene<NewsDetailsPresenterInput> {
        let view = NewsDetailsViewController()
        let presenter = NewsDetailsPresenter(view: view, newsId: id)
        view.output = presenter

        return Scene(presenter: presenter, view: view)
    }
}
