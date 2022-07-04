//
//  HeroDetailsView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

final class HeroDetailsView: UIView {
    // MARK: - Public Properties
    
    weak var uiDelegate: HeroDetailsViewUiDelegate?
    
    // MARK: - Private Properties
    
    private lazy var characterImageView: ImageLoader = {
        return ImageLoader(frame: .zero)
    }()
    
    private lazy var descrpLabel: UILabel = {
        return HeroDetailsView.makeDescrpLabel()
    }()
    
    private lazy var explMoreLabel: UILabel = {
        return HeroDetailsView.makeExplMoreLabel()
    }()
    
    private lazy var explMoreCollectionView: ExploreMoreCollectionView = {
        return HeroDetailsView.makeExplMoreCollectionView(self, self)
    }()
    
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
        setupViews()
    }
    
    // MARK: - Methods
    
    func updateUI(with model: HeroSeleсtingCellModel?) {
        guard let model = model else { return }
                
        characterImageView.loadImage(from: model.url)
        descrpLabel.text = model.description.isEmpty ? Localization.descriptionText.localizedString : model.description
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = Palette.GlobalColor.backgroundPrimary
    }
    
    private func setupViews() {
        setupView(characterImageView)
        setupView(descrpLabel)
        setupView(explMoreLabel)
        setupView(explMoreCollectionView)
    }
    
    // MARK: - Creating Subviews
    
    static func makeDescrpLabel() -> UILabel {
        let label = UILabel()
        label.font = FontLibrary.SFPro.regular14
        label.textColor = Palette.GlobalColor.fontPrimary
        label.numberOfLines = Constants.descrpNumberOfLines
        
        return label
    }
    
    static func makeExplMoreLabel() -> UILabel {
        let label = UILabel()
        label.font = FontLibrary.SFPro.bold34
        label.text = Localization.exploreMoreTitle.localizedString
        label.textColor = Palette.GlobalColor.fontPrimary
        
        return label
    }
    
    static func makeExplMoreCollectionView(_ actionsDelegate: ExploreMoreCollectionViewActionsDelegate, _ dataSourceDelegate: ExploreMoreCollectionViewDataSourceDelegate) -> ExploreMoreCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = Constants.FlowLayout.baseInsets
        
        let collectionView = ExploreMoreCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.actionDelegate = actionsDelegate
        collectionView.dataDelegate = dataSourceDelegate
        
        return collectionView
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activateCharacterImageViewConstraints()
        
        descrpLabel.sizeToFit()
        activateDescrpLabelConstraints()
        
        activateExploreMoreLabelConstraints()
        
        activateExploreMoreCollectionViewConstraints()
    }
    
    private func activateCharacterImageViewConstraints() {
        let subview = characterImageView
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            subview.centerXAnchor.constraint(equalTo: centerXAnchor),
            subview.heightAnchor.constraint(equalToConstant: bounds.width),
            subview.widthAnchor.constraint(equalToConstant: bounds.width)
        ])
    }
    
    private func activateDescrpLabelConstraints() {
        let subview = descrpLabel
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor,
                                             constant: Constants.AutoLayout.baseOffset),
            subview.topAnchor.constraint(equalTo: characterImageView.bottomAnchor,
                                         constant: Constants.AutoLayout.baseOffset),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor,
                                              constant: -Constants.AutoLayout.baseOffset),
            subview.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.AutoLayout.descrpLabelHeightValue)
        ])
    }
    
    private func activateExploreMoreLabelConstraints() {
        let subview = explMoreLabel
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor,
                                             constant: Constants.AutoLayout.baseOffset),
            subview.topAnchor.constraint(equalTo: descrpLabel.bottomAnchor,
                                         constant: Constants.AutoLayout.explMoreLabelTopOffset)
        ])
    }
    
    private func activateExploreMoreCollectionViewConstraints() {
        let subview = explMoreCollectionView
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            subview.topAnchor.constraint(equalTo: explMoreLabel.bottomAnchor,
                                         constant: Constants.AutoLayout.CollectionViewTopOffset),
            subview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            subview.heightAnchor.constraint(equalToConstant: Constants.AutoLayout.CollectionViewHeightValue)
        ])
    }
}

// MARK: - ExploreMoreCollectionViewActionsDelegate

extension HeroDetailsView: ExploreMoreCollectionViewActionsDelegate {
}

// MARK: - ExploreMoreCollectionViewDataSourceDelegate

extension HeroDetailsView: ExploreMoreCollectionViewDataSourceDelegate {
}

// MARK: - Constants

private extension HeroDetailsView {
    enum Constants {
        static let descrpNumberOfLines = 0
        
        enum AutoLayout {
            static let baseOffset: CGFloat = 16
            
            static let descrpLabelHeightValue: CGFloat = 148
            
            static let explMoreLabelTopOffset: CGFloat = 30
            
            static let CollectionViewTopOffset: CGFloat = 18
            static let CollectionViewHeightValue: CGFloat = 120
        }
        
        enum FlowLayout {
            static let baseInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
}
