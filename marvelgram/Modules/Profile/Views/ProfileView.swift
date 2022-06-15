//
//  ProfileView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

class ProfileView: UIView {
    // MARK: - Public Properties
    
    weak var uiDelegate: ProfileViewUiDelegate?
    
    // MARK: - Private Properties
    
    private enum LayoutConstants {
        static let padding: CGFloat = 15
        static let spacing: CGFloat = 18
        static let maxCountOfLines: Int = 0
        
        static let collectionViewHeightAnchor: CGFloat = 120
    }
    
    private lazy var heroImageView: HeroImageView = {
        return HeroImageView(frame: .zero)
    }()
    
    private lazy var heroDescrpLabel: UILabel = {
        return ProfileView.makeHeroDescrpLabel()
    }()
    
    private lazy var explMoreLabel: UILabel = {
        return ProfileView.makeExplMoreLabel()
    }()
    
    private lazy var explMoreCollectionView: ExploreMoreCollectionView = {
        return ProfileView.makeExplMoreCollectionView(self, self)
    }()
    
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        backgroundColor = UIColor(color: .background)
    }
    
    private func addSubviews() {
        addSubview(heroImageView)
        addSubview(heroDescrpLabel)
        addSubview(explMoreLabel)
        addSubview(explMoreCollectionView)
    }
    
    // MARK: - Creating Subviews
    
    static func makeHeroDescrpLabel() -> UILabel {
        let label = UILabel()
        label.font = Typography.paragraph.value
        label.text = LocalizableStrings.spideySubtitle.localizedString
        label.textColor = UIColor(color: .title1)
        label.numberOfLines = LayoutConstants.maxCountOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    static func makeExplMoreLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(color: .title1)
        label.font = Typography.display1.value
        label.text = LocalizableStrings.exploreMoreTitle.localizedString
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        activateHeroImageViewConstraints()
        activateHeroDescrpLabelConstraints()
        activateExploreMoreLabelConstraints()
        activateExploreMoreCollectionViewConstraints()
    }
    
    private func activateHeroImageViewConstraints() {
        NSLayoutConstraint.activate([
            heroImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            heroImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            heroImageView.heightAnchor.constraint(equalToConstant: bounds.width),
            heroImageView.widthAnchor.constraint(equalToConstant: bounds.width)
        ])
    }
    
    private func activateHeroDescrpLabelConstraints() {
        NSLayoutConstraint.activate([
            heroDescrpLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                     constant: LayoutConstants.padding),
            heroDescrpLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor,
                                                 constant: LayoutConstants.padding),
            heroDescrpLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                      constant: -LayoutConstants.padding)
        ])
        
        _ = heroDescrpLabel.sizeThatFits(bounds.size).height
    }
    
    private func activateExploreMoreLabelConstraints() {
        NSLayoutConstraint.activate([
            explMoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: LayoutConstants.padding),
            explMoreLabel.topAnchor.constraint(equalTo: heroDescrpLabel.bottomAnchor,
                                               constant: LayoutConstants.spacing)
        ])
    }
    
    private func activateExploreMoreCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            explMoreCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                            constant: LayoutConstants.padding),
            explMoreCollectionView.topAnchor.constraint(equalTo: explMoreLabel.bottomAnchor,
                                                        constant: LayoutConstants.spacing),
            explMoreCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                             constant: -LayoutConstants.padding),
            explMoreCollectionView.heightAnchor.constraint(equalToConstant: LayoutConstants.collectionViewHeightAnchor)
//            explMoreCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - ExploreMoreCollectionViewActionsDelegate

extension ProfileView: ExploreMoreCollectionViewActionsDelegate {
}

// MARK: - ExploreMoreCollectionViewDataSourceDelegate

extension ProfileView: ExploreMoreCollectionViewDataSourceDelegate {
}
