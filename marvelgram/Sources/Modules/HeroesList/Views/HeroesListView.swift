import UIKit

protocol HeroesListViewUiDelegate: AnyObject {
}

final class HeroesListView: UIView {
    
    weak var uiDelegate: HeroesListViewUiDelegate?
    
    private lazy var heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView = {
        makeHeroesSeleсtingCollectionView(self, self)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = AppColor.GlobalColor.background
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = AppColor.GlobalColor.background
        setupUI()
    }
    
    private func setupUI() {
        addSubview(heroesSeleсtingCollectionView)
        activateHeroesCollectionViewConstraints()
    }
    
    // MARK: - Creating Subviews
    
    private func makeHeroesSeleсtingCollectionView(
        _ actionDelegate: HeroesSeleсtingCollectionViewActionDelegate,
        _ dataSourceDelegate: HeroesSeleсtingCollectionViewDataSourceDelegate) -> HeroesSeleсtingCollectionView {
            let layout = DefaultGridFlowLayout()
            
            let collectionView = HeroesSeleсtingCollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.actionDelegate = actionDelegate
            collectionView.dataSourceDelegate = dataSourceDelegate
            
            return collectionView
        }
    
    // MARK: - AutoLayout
    
    private func activateHeroesCollectionViewConstraints() {
        let subview = heroesSeleсtingCollectionView
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - ActionDelegate

extension HeroesListView: HeroesSeleсtingCollectionViewActionDelegate {
}

// MARK: - DataSourceDelegate

extension HeroesListView: HeroesSeleсtingCollectionViewDataSourceDelegate {
}
