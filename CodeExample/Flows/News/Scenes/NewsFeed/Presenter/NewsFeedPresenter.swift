//
//  NewsFeedPresenter.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import UIKit
import SLFoundation

/// Презентер новостной ленты
final class NewsFeedPresenter {
    weak var output: NewsFeedPresenterOutput?

    private let view: NewsFeedViewInput
    private let countInGroup = 7

    private var tagsCellViewModel: TagsCellViewModel?
    private var allTags: [String] = []
    private var viewModels: [NewsCellViewModel] = []
    private var selectedTagIndex = 0 {
        didSet {
            updateTagButtons()
        }
    }

    /// Инициализирует презентер новостной ленты
    /// - Parameters:
    ///   - view: Вью
    init(view: NewsFeedViewInput) {
        self.view = view
    }
}

extension NewsFeedPresenter: NewsFeedPresenterInput {
    func presentContent(residentialComplexName: String, models: [NewsCardModel]) {
        var tags: Set<String> = []
        models.forEach { tags.formUnion($0.tags) }

        let tagButtonCellViewModel = createTagButtonCellViewModel(buttonTitle: residentialComplexName)
        let headerCellViewModel = createHeaderCellViewModel(headerText: "Новости")
        let tagsCellViewModel = createTagsCellViewModel(tags: Array(tags).sorted())

        self.tagsCellViewModel = tagsCellViewModel

        let headerSectionViewModel = BaseUniversalTableSectionViewModel(
            items: [tagButtonCellViewModel, headerCellViewModel, tagsCellViewModel]
        )
        selectedTagIndex = 0

        let viewModels = createNewsCellViewModels(with: models)
        self.viewModels = viewModels
        let sectionViewModel = BaseUniversalTableSectionViewModel(items: viewModels)

        view.showContent(sectionViewModels: [headerSectionViewModel, sectionViewModel])
    }

    func presentError(with error: UniversalSenderError) {
        view.showError(message: "Не удалось загрузить данные")
    }

    func updateContent() {
        view.showLoader()
        output?.requestNewsFeed(self)
    }

    func updateImage(data: Data?, newsId: String) {
        guard let viewModel = viewModels.first(where: { $0.id == newsId }),
              let data = data,
              let image = UIImage(data: data)
        else {
            return
        }

        viewModel.photo = image
    }

    private func createTagButtonCellViewModel(buttonTitle: String?) -> TagButtonCellViewModel {
        let viewModel = TagButtonCellViewModel(buttonTitle: buttonTitle)
        viewModel.onButtonTap = { [unowned self] in
            self.output?.startResidentialComplexSelection(self)
        }

        return viewModel
    }

    private func createHeaderCellViewModel(headerText: String?) -> HeaderCellViewModel {
        HeaderCellViewModel(title: headerText)
    }

    private func createTagsCellViewModel(tags: [String]) -> TagsCellViewModel {
        allTags = ["Все"] + tags

        let viewModel = TagsCellViewModel(tags: allTags)
        viewModel.onTagButtonTap = { [unowned self] index in
            self.selectedTagIndex = index
            self.filterContent()
        }

        return viewModel
    }

    private func createNewsCellViewModels(with models: [NewsCardModel]) -> [NewsCellViewModel] {
        var viewModels: [NewsCellViewModel] = []

        for (index, model) in models.enumerated() {
            var captions = [formattedDate(model.date)]
            if let partnerName = model.partnerName {
                captions.append(partnerName)
            }
            let partnerLogo = ImageLoader.image(from: model.partnerLogo)
            let viewModel = NewsCellViewModel(
                id: model.id,
                tags: model.tags,
                size: (index % countInGroup) == 0 ? .large : .small,
                titleText: model.title,
                captions: captions,
                photo: UIImage(named: "placeHolder"),
                partnerLogo: partnerLogo
            )
            viewModel.onTap = { [unowned self] viewModel in
                self.output?.didSelectNews(self, with: viewModel.id)
            }
            output?.loadImage(self, id: model.mainPhotoId, newsId: model.id)

            viewModels.append(viewModel)
        }

        return viewModels
    }

    private func updateTagButtons() {
        tagsCellViewModel?.selectedTagIndex = selectedTagIndex
    }

    private func filterContent() {
        let filteredViewModels = viewModels.filter { viewModel in
            guard selectedTagIndex > 0 else { return true }

            let tag = allTags[selectedTagIndex]

            return viewModel.tags.contains(tag)
        }

        for (index, viewModel) in filteredViewModels.enumerated() {
            viewModel.size = (index % countInGroup) == 0 ? .large : .small
        }

        let section = BaseUniversalTableSectionViewModel(items: filteredViewModels)

        view.updateContentSection(with: section)
    }

    private func formattedDate(_ date: Date) -> String {
        guard !date.hasSame([.day, .month, .year], as: Date()) else {
            return "Сегодня"
        }
        return date.format("dd MMM")
    }
}

extension NewsFeedPresenter: NewsFeedViewOutput {
    func didLoad() {
        view.showLoader()
        output?.requestNewsFeed(self)
    }

    func fetchContent() {
        view.showLoader()
        output?.requestNewsFeed(self)
    }

    func onResidentialComplexButtonTap() {
        output?.startResidentialComplexSelection(self)
    }
}
