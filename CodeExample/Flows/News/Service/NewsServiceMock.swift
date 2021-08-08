//
//  NewsServiceMock.swift
//  Mesta
//
//  Created by Sergey Dunaev on 12.06.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import Foundation
import SLFoundation

/// Мок сервиса новостей
final class NewsServiceMock {
    private let newsCardModels = [
        NewsCardModel(
            id: "1",
            title: "Ролл-сэндвич с красной рыбкой",
            mainPhotoId: "Mock/Foods/01",
            date: Date(),
            partnerName: "Starbucks",
            partnerLogo: ImageLoaderMock.base64(named: "Mock/Partners/starbucksLogo"),
            tags: ["Акции"]
        ),
        NewsCardModel(
            id: "2",
            title: "Аптека",
            mainPhotoId: "Mock/Foods/02",
            date: Date(),
            partnerName: nil,
            partnerLogo: nil,
            tags: ["Акции"]
        ),
        NewsCardModel(
            id: "3",
            title: "БиоБрот",
            mainPhotoId: "Mock/Foods/03",
            date: Date(),
            partnerName: "БиоБрот",
            partnerLogo: ImageLoaderMock.base64(named: "Mock/Partners/bioBrotLogo"),
            tags: ["Места", "Магазины"]
        ),
        NewsCardModel(
            id: "4",
            title: "Ролл-сэндвич с красной рыбкой",
            mainPhotoId: "Mock/Foods/04",
            date: Date(),
            partnerName: "Starbucks",
            partnerLogo: ImageLoaderMock.base64(named: "Mock/Partners/starbucksLogo"),
            tags: ["Акции"]
        ),
        NewsCardModel(
            id: "5",
            title: "Аптека",
            mainPhotoId: "Mock/Foods/05",
            date: Date(),
            partnerName: nil,
            partnerLogo: nil,
            tags: ["Новости района"]
        ),
        NewsCardModel(
            id: "6",
            title: "БиоБрот",
            mainPhotoId: "Mock/Foods/06",
            date: Date(),
            partnerName: "БиоБрот",
            partnerLogo: ImageLoaderMock.base64(named: "Mock/Partners/bioBrotLogo"),
            tags: ["Акции"]
        ),
        NewsCardModel(
            id: "7",
            title: "Ролл-сэндвич с красной рыбкой",
            mainPhotoId: "Mock/Foods/07",
            date: Date(),
            partnerName: "Starbucks",
            partnerLogo: ImageLoaderMock.base64(named: "Mock/Partners/starbucksLogo"),
            tags: ["Новости района", "Акции"]
        ),
        NewsCardModel(
            id: "8",
            title: "Аптека",
            mainPhotoId: "Mock/Foods/08",
            date: Date(),
            partnerName: nil,
            partnerLogo: nil,
            tags: ["Акции"]
        ),
        NewsCardModel(
            id: "9",
            title: "БиоБрот",
            mainPhotoId: "Mock/Foods/09",
            date: Date(),
            partnerName: "БиоБрот",
            partnerLogo: ImageLoaderMock.base64(named: "Mock/Partners/bioBrotLogo"),
            tags: ["Мероприятия"]
        )
    ]

    private let newsModel = NewsModel(
        id: "1",
        title: "Мы нашли самое вкусное мороженое в Москве",
        content: """
            В последнее время выбрать хорошее мороженое получается не всегда. Дело в том, что производители добавляют в лакомство такие составляющие, которые отрицательно сказываются на вкусе и качестве продукта. Чтобы вы не столкнулись с такими проблемами, мы составили рейтинг лучшего мороженого, в который вошло, в том числе, лакомство, являющимся лучшим, по мнению Роскачества.

            При составлении рейтинга мы учитывали состав и характеристики лакомства. Кроме того, мы брали во внимание мнение Роскачества, отзывы пользователей, плюсы и минусы каждого продукта ТОПа.
            """,
        additionalPhotoIds: [
            "Mock/Foods/01",
            "Mock/Foods/02",
            "Mock/Foods/03",
            "Mock/Foods/04",
            "Mock/Foods/05"
        ],
        date: Date(),
        address: "ул. Вернадского 32, подъезд 2. Вход со стороны парковки",
        partnerId: "2",
        partnerName: "Starbucks",
        partnerLogo: ImageLoaderMock.base64(named: "Mock/Partners/starbucksLogo")
    )
}

extension NewsServiceMock: NewsServiceInput {
    func fetchNewsFeed(
        residentialComplexId: String,
        completion: @escaping (Result<[NewsCardModel], UniversalSenderError>) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(self.newsCardModels))
        }
    }

    func fetchNewsDetails(newsId: String, completion: @escaping (Result<NewsModel, UniversalSenderError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(self.newsModel))
        }
    }
}
