//
//  NewsCoordinatorAssembler.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import SLFoundation

/// Сборщик координатора новостей
public final class NewsCoordinatorAssembler {
    public init() {}

    /// Создает координатор новостей
    /// - Parameters:
    ///   - router: Роутер
    /// - Returns: Возвращает координатор новостей
    public func makeCoordinator(router: Router) -> NewsCoordinatorInput {
        let service = NewsServiceAssembler().makeService()
        let imageLoader = ImageLoaderAssembler().makeService()
        let dataManager: GeneralDataManagerInput = Resolver.resolve()
        let interactor = NewsInteractor(service: service, imageLoader: imageLoader, dataManager: dataManager)
        let sceneAssembler = NewsSceneAssembler()
        let coordinator = NewsCoordinator(
            router: router,
            interactor: interactor,
            sceneAssembler: sceneAssembler,
            coordinatorFactory: BaseCoordinatorFactory()
        )
        interactor.output = coordinator

        return coordinator
    }
}
