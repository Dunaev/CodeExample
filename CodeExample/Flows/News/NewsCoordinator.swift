//
//  NewsCoordinator.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import Foundation
import SLFoundation

/// Координатор новостей
final class NewsCoordinator: BaseTabCoordinator {
    weak var output: BaseTabCoordinatorOutput?

    private let router: Router
    private let interactor: NewsInteractorInput
    private let sceneAssembler: NewsSceneAssemblerInput
    private let coordinatorFactory: CoordinatorFactory

    private var newsDetailsScene: Scene<NewsDetailsPresenterInput>?

    private lazy var newsFeedScene: Scene<NewsFeedPresenterInput> = {
        let scene = sceneAssembler.makeNewsFeedScene()
        scene.presenter.output = self

        return scene
    }()

    /// Инициализирует координатор новостей
    /// - Parameters:
    ///   - router: Роутер
    ///   - interactor: Интерактор
    ///   - sceneAssembler: Сборщик сцен
    ///   - coordinatorFactory: Фабрика координаторов
    init(
        router: Router,
        interactor: NewsInteractorInput,
        sceneAssembler: NewsSceneAssemblerInput,
        coordinatorFactory: CoordinatorFactory
    ) {
        self.router = router
        self.interactor = interactor
        self.sceneAssembler = sceneAssembler
        self.coordinatorFactory = coordinatorFactory
    }

    override func start() {
        super.start()
        showNewsFeedScene()
    }

    private func showNewsFeedScene() {
        router.setRootModule(newsFeedScene)
    }

    private func showNewsDetails(with id: String) {
        newsDetailsScene = sceneAssembler.makeNewsDetailsScene(with: id)
        newsDetailsScene?.presenter.output = self

        let presentMode = RouterScenePresentMode.modalPageSheet(dismissible: true)

        router.present(newsDetailsScene, mode: presentMode, animated: true) { [unowned self] in
            self.newsDetailsScene = nil
        }
    }
}

extension NewsCoordinator: NewsCoordinatorInput {
}

extension NewsCoordinator: NewsInteractorOutput {
    func didReceiveNewsFeed(residentialComplexName: String, models: [NewsCardModel]) {
        newsFeedScene.presenter.presentContent(residentialComplexName: residentialComplexName, models: models)
    }

    func didReceiveNewsFeedError(error: UniversalSenderError) {
        newsFeedScene.presenter.presentError(with: error)
    }

    func didReceiveNewsDetails(model: NewsModel) {
        newsDetailsScene?.presenter.presentContent(model: model)
    }

    func didReceiveNewsDetailsError(error: UniversalSenderError) {
        newsDetailsScene?.presenter.presentError(with: error)
    }

    func didReceiveImage(data: Data?, newsId: String) {
        newsFeedScene.presenter.updateImage(data: data, newsId: newsId)
    }

    func didReceiveAdditionalPhoto(data: Data?, photoId: String) {
        newsDetailsScene?.presenter.updateImage(data: data, photoId: photoId)
    }
}

extension NewsCoordinator: NewsFeedPresenterOutput {
    func requestNewsFeed(_ presenter: NewsFeedPresenterInput) {
        interactor.fetchNewsFeed()
    }

    func startResidentialComplexSelection(_ presenter: NewsFeedPresenterInput) {
        let (coordinator, navigationController) = coordinatorFactory.makeResidentialComplexSelectionCoordinatorBox()
        coordinator.output = self
        addDependency(coordinator)
        coordinator.start()

        router.present(navigationController, mode: .modalPageSheet(dismissible: false))
    }

    func didSelectNews(_ presenter: NewsFeedPresenterInput, with id: String) {
        showNewsDetails(with: id)
    }

    func loadImage(_ presenter: NewsFeedPresenterInput, id: String, newsId: String) {
        interactor.loadImage(id: id, newsId: newsId)
    }
}

extension NewsCoordinator: ResidentialComplexSelectionCoordinatorOutput {
    func didSelectResidentialComplex(_ coordinator: ResidentialComplexSelectionCoordinatorInput, with id: String) {
        removeDependency(coordinator)
        newsFeedScene.presenter.updateContent()
        router.dismissModule()
    }

    func didCancelSelectionResidentialComplex(_ coordinator: ResidentialComplexSelectionCoordinatorInput) {
        removeDependency(coordinator)
        router.dismissModule()
    }
}

extension NewsCoordinator: NewsDetailsPresenterOutput {
    func requestNewsDetails(_ presenter: NewsDetailsPresenterInput, id: String) {
        interactor.fetchNewsDetails(with: id)
    }

    func loadImage(_ presenter: NewsDetailsPresenterInput, with photoId: String) {
        interactor.loadAdditionalPhoto(with: photoId)
    }
}
