//
//  NewsDetailsViewOutput.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

protocol NewsDetailsViewOutput: AnyObject {
    /// Вызывается после загрузки viewController'а
    func didLoad()

    /// Вызывается при запросе контента
    func fetchContent()
}
