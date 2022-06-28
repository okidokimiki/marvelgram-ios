//
//  DetailView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

class DetailView: UIView {
    // MARK: - Public Properties
    
    weak var uiDelegate: DetailViewUiDelegate?
    
    // MARK: - Private Properties
    
    private lazy var characterImageView: CharacterImageView = {
        return CharacterImageView(frame: .zero)
    }()
    
    private lazy var descrpLabel: UILabel = {
        return DetailView.makeDescrpLabel()
    }()
    
    private lazy var explMoreLabel: UILabel = {
        return DetailView.makeExplMoreLabel()
    }()
    
    private lazy var explMoreCollectionView: ExploreMoreCollectionView = {
        return DetailView.makeExplMoreCollectionView(self, self)
    }()
    
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = UIColor(assets: .background)
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
        label.text = Localization.spideySubtitle.localizedString
        label.textColor = UIColor(assets: .title)
        label.numberOfLines = Constants.descrpNumberOfLines
        
        return label
    }
    
    static func makeExplMoreLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(assets: .title)
        label.font = FontLibrary.SFPro.bold34
        label.text = Localization.exploreMoreTitle.localizedString
        
        return label
    }
    
    static func makeExplMoreCollectionView(_ actionsDelegate: ExploreMoreCollectionViewActionsDelegate, _ dataSourceDelegate: ExploreMoreCollectionViewDataSourceDelegate) -> ExploreMoreCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = ExploreMoreCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.actionsDelegate = actionsDelegate
        collectionView.dataSourceDelegate = dataSourceDelegate
        
        return collectionView
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activateCharacterImageViewConstraints()
        
        activateDescrpLabelConstraints()
        _ = descrpLabel.sizeThatFits(bounds.size).height
        
        activateExploreMoreLabelConstraints()
        
        activateExploreMoreCollectionViewConstraints()
    }
    
    private func activateCharacterImageViewConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            characterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: bounds.width),
            characterImageView.widthAnchor.constraint(equalToConstant: bounds.width)
        ])
    }
    
    private func activateDescrpLabelConstraints() {
        NSLayoutConstraint.activate([
            descrpLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                 constant: Constants.AutoLayout.baseOffset),
            descrpLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor,
                                             constant: Constants.AutoLayout.baseOffset),
            descrpLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                  constant: -Constants.AutoLayout.baseOffset)
        ])
    }
    
    private func activateExploreMoreLabelConstraints() {
        NSLayoutConstraint.activate([
            explMoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: Constants.AutoLayout.baseOffset),
            explMoreLabel.topAnchor.constraint(equalTo: descrpLabel.bottomAnchor,
                                               constant: Constants.AutoLayout.explMoreLabelTopOffset)
        ])
    }
    
    private func activateExploreMoreCollectionViewConstraints() {
        let collectionView = explMoreCollectionView
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                    constant: Constants.AutoLayout.baseOffset),
            collectionView.topAnchor.constraint(equalTo: explMoreLabel.bottomAnchor,
                                                constant: Constants.AutoLayout.explMoreCollectionTopOffset),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -Constants.AutoLayout.baseOffset),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                                   constant: -Constants.AutoLayout.explMoreCollectionBottomOffset)
        ])
    }
}

// MARK: - ExploreMoreCollectionViewActionsDelegate

extension DetailView: ExploreMoreCollectionViewActionsDelegate {
}

// MARK: - ExploreMoreCollectionViewDataSourceDelegate

extension DetailView: ExploreMoreCollectionViewDataSourceDelegate {
}

// MARK: - Constants

private extension DetailView {
    enum Constants {
        static let descrpNumberOfLines = 0
        
        enum AutoLayout {
            static let baseOffset: CGFloat = 16
            
            static let explMoreLabelTopOffset: CGFloat = 30
            
            static let explMoreCollectionTopOffset: CGFloat = 18
            static let explMoreCollectionBottomOffset: CGFloat = 10
        }
    }
}
