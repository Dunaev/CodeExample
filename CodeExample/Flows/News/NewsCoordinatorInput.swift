//
//  NewsCoordinatorInput.swift
//  Mesta
//
//  Created by Sergey Dunaev on 05.05.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import SLFoundation

/// Протокол описывает координатор новостей
public protocol NewsCoordinatorInput: TabCoordinator {
    /// Делегат
    var output: BaseTabCoordinatorOutput? { get set }
}
