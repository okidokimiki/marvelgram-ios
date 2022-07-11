//
//  HeroDetailsView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

protocol HeroDetailsViewUiDelegate: AnyObject {
    // Actions
    func heroDetailsView(_ heroDetailsView: HeroDetailsView, didSelectCharWithIndex index: Int)
    
    // DataSource
    func heroDetailsView(_ heroDetailsView: HeroDetailsView, getCellsCountOf reuseIdentifier: String) -> Int?
    func heroDetailsView(_ heroDetailsView: HeroDetailsView, getOtherCharCellModelWithIndex index: Int) -> HeroSeleсtingCellModel?
}

final class HeroDetailsView: UIView {
    // MARK: - Properties
    
    weak var uiDelegate: HeroDetailsViewUiDelegate?
    
    // MARK: - Private Properties
    
    private lazy var scrollView: VericalScrollView = {
        return VericalScrollView(frame: .zero)
    }()
    
    private lazy var characterImageView: ImageLoader = {
        return ImageLoader(frame: .zero)
    }()
    
    private lazy var descrpLabel: TopAlignedLabel = {
        return makeDescrpLabel()
    }()
    
    private lazy var exploreMoreLabel: UILabel = {
        return makeExploreMoreLabel()
    }()
    
    private lazy var otherCharCollectionView: OtherCharactersCollectionView = {
        return makeOtherCharCollectionView(uiDelegate: self)
    }()
    
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupViews()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
        setupViews()
        setupAutoLayout()
    }
    
    // MARK: - Methods
    
    func updateUI(with model: HeroSeleсtingCellModel?) {
        guard let model = model else { return }
        
        otherCharCollectionView.reloadData()
        characterImageView.loadImage(from: model.url)
        descrpLabel.text = model.description.isEmpty ? AppLocalize.HeroDetails.descriptionText : model.description
    }
    
    func finishLayoutSubviews() {
        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
        descrpLabel.addInterlineSpacing(spacingValue: Constants.descrpLabelInterlineSpacing)
        activateSubviewsWidthLayoutConstraint()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = AppColor.GlobalColor.background
    }
    
    private func setupViews() {
        setupView(scrollView)
        scrollView.setupView(characterImageView)
        scrollView.setupView(descrpLabel)
        scrollView.setupView(exploreMoreLabel)
        scrollView.setupView(otherCharCollectionView)
    }
    
    private func setupAutoLayout() {
        activateScrollViewConstraints()
        activateCharacterImageViewConstraints()
        activateDescrpLabelConstraints()
        activateExploreMoreLabelConstraints()
        activateOtherCharCollectionViewConstraints()
    }
    
    // MARK: - Creating Subviews
    
    private func makeDescrpLabel() -> TopAlignedLabel {
        let label = TopAlignedLabel()
        label.font = AppFont.SFPro.regular14
        label.textColor = AppColor.GlobalColor.font
        label.numberOfLines = Constants.descrpLabelNumberOfLines
        
        return label
    }
    
    private func makeExploreMoreLabel() -> UILabel {
        let label = UILabel()
        label.font = AppFont.SFPro.bold34
        label.text = AppLocalize.HeroDetails.exploreMoreTitle
        label.textColor = AppColor.GlobalColor.font
        
        return label
    }
    
    private func makeOtherCharCollectionView(uiDelegate: OtherCharactersCollectionViewUiDelegate) -> OtherCharactersCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = Constants.FlowLayout.baseInsets
        
        let collectionView = OtherCharactersCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.uiDelegate = uiDelegate
        
        return collectionView
    }
    
    // MARK: - AutoLayout
    
    private func activateScrollViewConstraints() {
        let subview = scrollView
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            subview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func activateCharacterImageViewConstraints() {
        let subview = characterImageView
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: scrollView.topAnchor),
            subview.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    private func activateDescrpLabelConstraints() {
        let subview = descrpLabel
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: Constants.AutoLayout.baseOffset),
            subview.topAnchor.constraint(equalTo: characterImageView.bottomAnchor,
                                         constant: Constants.AutoLayout.baseOffset),
            subview.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.AutoLayout.descrpLabelHeightValue)
        ])
    }
    
    private func activateExploreMoreLabelConstraints() {
        let subview = exploreMoreLabel
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: Constants.AutoLayout.baseOffset),
            subview.topAnchor.constraint(equalTo: descrpLabel.bottomAnchor)
        ])
    }
    
    private func activateOtherCharCollectionViewConstraints() {
        let subview = otherCharCollectionView
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            subview.topAnchor.constraint(equalTo: exploreMoreLabel.bottomAnchor,
                                         constant: Constants.AutoLayout.otherCharCollectionViewTopOffset),
            subview.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            subview.heightAnchor.constraint(equalToConstant: Constants.AutoLayout.otherCharCollectionViewHeightValue)
        ])
    }
    
    private func activateSubviewsWidthLayoutConstraint() {
        let width = scrollView.bounds.width
        NSLayoutConstraint.activate([
            characterImageView.heightAnchor.constraint(equalToConstant: width),
            characterImageView.widthAnchor.constraint(equalToConstant: width),
            otherCharCollectionView.widthAnchor.constraint(equalToConstant: width),
            descrpLabel.widthAnchor.constraint(equalToConstant: width - Constants.AutoLayout.descrpLabelTrailingOffset)
        ])
    }
}

// MARK: - UiDelegate

extension HeroDetailsView: OtherCharactersCollectionViewUiDelegate {
    // Actions
    func otherCharCollectionView(_ otherCharCollectionView: OtherCharactersCollectionView, didSelectCharWithIndex index: Int) {
        uiDelegate?.heroDetailsView(self, didSelectCharWithIndex: index)
    }
    
    // DataSource
    func otherCharCollectionView(_ otherCharCollectionView: OtherCharactersCollectionView, getOtherCharCellModelWithIndex index: Int) -> HeroSeleсtingCellModel? {
        return uiDelegate?.heroDetailsView(self, getOtherCharCellModelWithIndex: index)
    }
    func otherCharCollectionView(_ otherCharCollectionView: OtherCharactersCollectionView, getCellsCountOf reuseIdentifier: String) -> Int? {
        return uiDelegate?.heroDetailsView(self, getCellsCountOf: reuseIdentifier)
    }
}

// MARK: - Constants

private extension HeroDetailsView {
    enum Constants {
        static let descrpLabelNumberOfLines = 0
        static let descrpLabelInterlineSpacing: CGFloat =  1.32
        
        enum AutoLayout {
            static let baseOffset: CGFloat = 16
            
            static let descrpLabelTrailingOffset: CGFloat = 32
            static let descrpLabelHeightValue: CGFloat = 148
            
            static let otherCharCollectionViewTopOffset: CGFloat = 18
            static let otherCharCollectionViewHeightValue: CGFloat = 120
        }
        
        enum FlowLayout {
            static let baseInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
}
