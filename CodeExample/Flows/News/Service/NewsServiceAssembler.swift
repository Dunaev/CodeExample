//
//  NewsServiceAssembler.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import SLFoundation

/// Сборщик сервиса новостей
final class NewsServiceAssembler {
    /// Создает сервис новостей
    /// - Returns: Сервис новостей
    func makeService() -> NewsServiceInput {
        guard !ApplicationSettings.shared.isMockedServices else {
            return NewsServiceMock()
        }

        let sender = UniversalSenderAssembler().makeSender(host: ApplicationSettings.shared.host)
        let service = NewsService(sender: sender)

        return service
    }
}
