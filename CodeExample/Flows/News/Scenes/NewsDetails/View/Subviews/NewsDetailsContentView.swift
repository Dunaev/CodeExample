//
//  NewsDetailsContentView.swift
//  Mesta
//
//  Created by Sergey Dunaev on 21.07.2021.
//  Copyright © 2021 SwiftLab. All rights reserved.
//

import UIKit

/// Вью с контентом подробной информации новости
final class NewsDetailsContentView: UIView {
    private var imageViews: [UIImageView] = []

    private lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true

        return scrollView
    }()

    private lazy var topContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8

        return stackView
    }()

    private lazy var imageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self

        return scrollView
    }()

    private lazy var imageContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0

        return stackView
    }()

    private lazy var pageIndicator: PageIndicator = {
        let pageIndicator = PageIndicator()

        return pageIndicator
    }()

    private lazy var mainContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    private lazy var dateLabel = Label(typography: .caption1, colorToken: .textTertiary)

    private lazy var titleLabel: Label = {
        let label = Label(typography: .headline1, colorToken: .textDefault)
        label.numberOfLines = 0

        return label
    }()

    private lazy var partnerBackground: BackgroundAtom = {
        let backgroundAtom = BackgroundAtom(colorToken: .infographicBlack05)
        backgroundAtom.cornerRadius = 12

        return backgroundAtom
    }()

    private lazy var partnerLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 56, height: 56))
        }

        return imageView
    }()

    private lazy var partnerNameLabel: Label = {
        let label = Label(typography: .headline4, colorToken: .textDefault)
        label.numberOfLines = 2

        return label
    }()

    private lazy var partnerAddressLabel: Label = {
        let label = Label(typography: .paragraph, colorToken: .textSecondary)
        label.numberOfLines = 0

        return label
    }()

    private lazy var textView: BaseTextView = {
        let textView = BaseTextView(textTypography: .paragraphRead, textColorToken: .textDefault)
        textView.isScrollEnabled = false
        textView.isEnabled = false

        return textView
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateContent(with model: NewsDetailsViewModel) {
        if !model.photos.isEmpty {
            imageScrollView.isHidden = false
            pageIndicator.isHidden = false
            generatePictures(images: model.photos)
            pageIndicator.pageCount = model.photos.count
        } else {
            imageScrollView.isHidden = true
            pageIndicator.isHidden = true
        }

        dateLabel.text = model.date
        titleLabel.text = model.title
        partnerLogo.image = model.partnerLogo
        partnerNameLabel.text = model.partnerName
        partnerAddressLabel.text = model.partnerAddress
        textView.text = model.content

        partnerBackground.isHidden = model.partnerLogo == nil && model.partnerName == nil
    }

    func updateImage(_ image: UIImage, with index: Int) {
        imageViews[index].image = image
    }

    private func setupView() {
        setupMainScrollView()
        setupTopContainer()
        setupImageScrollView()
        setupImageContainer()
        setupPageIndicator()
        setupMainContainer()
        setupDateLabel()
        setupTitleLabel()
        setupPartnerBackground()
        setupTextView()
    }

    private func setupMainScrollView() {
        addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupTopContainer() {
        mainScrollView.addSubview(topContainer)
        topContainer.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

    private func setupImageScrollView() {
        topContainer.addArrangedSubview(imageScrollView)
        imageScrollView.snp.makeConstraints { make in
            make.height.equalTo(imageScrollView.snp.width).multipliedBy(1)
        }
    }

    private func setupImageContainer() {
        imageScrollView.addSubview(imageContainer)
        imageContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
    }

    private func setupPageIndicator() {
        topContainer.addArrangedSubview(pageIndicator)
    }

    private func setupMainContainer() {
        mainScrollView.addSubview(mainContainer)
        mainContainer.snp.makeConstraints { make in
            make.top.equalTo(topContainer.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

    private func setupDateLabel() {
        mainContainer.addArrangedSubview(dateLabel)
        mainContainer.setCustomSpacing(4, after: dateLabel)
    }

    private func setupTitleLabel() {
        mainContainer.addArrangedSubview(titleLabel)
        mainContainer.setCustomSpacing(24, after: titleLabel)
    }

    private func setupPartnerBackground() {
        partnerBackground.addSubview(partnerLogo)
        partnerLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(16)
            make.bottom.lessThanOrEqualToSuperview().offset(-12)
        }

        partnerBackground.addSubview(partnerNameLabel)
        partnerNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(partnerLogo.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
        }

        partnerBackground.addSubview(partnerAddressLabel)
        partnerAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(partnerNameLabel.snp.bottom)
            make.left.equalTo(partnerLogo.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.lessThanOrEqualToSuperview().offset(-12)
        }

        mainContainer.addArrangedSubview(partnerBackground)
        mainContainer.setCustomSpacing(32, after: partnerBackground)
    }

    private func setupTextView() {
        mainContainer.addArrangedSubview(textView)
    }

    private func generatePictures(images: [UIImage]) {
        imageContainer.subviews.forEach { $0.removeFromSuperview() }
        imageViews = []

        images.forEach { image in
            let imageView = UIImageView(image: image)
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.snp.makeConstraints { make in
                make.width.equalTo(imageView.snp.height)
            }
            imageContainer.addArrangedSubview(imageView)
            imageViews.append(imageView)
        }
    }
}

extension NewsDetailsContentView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        pageIndicator.currentPage = Int(scrollView.contentOffset.x / pageWidth)
    }
}
