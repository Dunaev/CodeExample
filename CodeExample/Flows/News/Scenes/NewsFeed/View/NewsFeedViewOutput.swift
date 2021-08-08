//
//  NewsFeedViewOutput.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

/// Протокол описывает делегат вью новостной ленты
protocol NewsFeedViewOutput: AnyObject {
    /// Вызывается после загрузки viewController'а
    func didLoad()

    /// Запрашивает контент
    func fetchContent()

    /// Вызывается при нажатии на кнопку выбора ЖК
    func onResidentialComplexButtonTap()
}
