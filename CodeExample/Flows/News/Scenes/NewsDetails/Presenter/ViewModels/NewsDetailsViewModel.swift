//
//  NewsDetailsViewModel.swift
//  Mesta
//
//  Created by Sergey Dunaev on 21.07.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import UIKit

/// Вью-модель подробной информации новости
struct NewsDetailsViewModel {
    /// Фотографии
    let photos: [UIImage]
    /// Дата новости
    let date: String
    /// Заголовок
    let title: String
    /// Логотип партнера
    let partnerLogo: UIImage?
    /// Название партнера
    let partnerName: String?
    /// Адрес партнера
    let partnerAddress: String?
    /// Контент новости
    let content: String
}
