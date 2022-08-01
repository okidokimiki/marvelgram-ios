import UIKit

protocol HeroesListViewUiDelegate: AnyObject {
    // - Actions
    func heroesListView(_ heroesListView: HeroesListView, didSelectHeroWithIndexPath indexPath: IndexPath)
    func heroesListView(_ heroesListView: HeroesListView, didMoveUpHeroWithAnimationResult result: Bool)
    func heroesListView(_ heroesListView: HeroesListView, willDisplayHeroWithIndexPath indexPath: IndexPath)
    
    // - DataSource
    func heroesListView(_ heroesListView: HeroesListView, getCellsCountOf reuseIdentifier: String) -> Int?
    func heroesListView(_ heroesListView: HeroesListView, getHeroCellModelWithIndexPath indexPath: IndexPath) -> HeroCellModel?
}

final class HeroesListView: UIView {
    
    weak var uiDelegate: HeroesListViewUiDelegate?
    
    private lazy var heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView = {
        makeHeroesSeleсtingCollectionView(self, self)
    }()
    
    private let launchActivityIndicatorView: UIActivityIndicatorView = {
        RemovebleActivityIndicatorView(frame: .zero)
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
    
    func showlaunchActivityIndicator(_ show: Bool) {
        if show {
            launchActivityIndicatorView.startAnimating()
        } else {
            launchActivityIndicatorView.stopAnimating()
        }
    }
    
    func reloadCollectionView() {
        heroesSeleсtingCollectionView.reloadData()
    }
    
    func scrollCollectionView(to direction: ScrollDirection) {
        var contentOffset: CGPoint = .zero
        
        switch direction {
        case .top:
            contentOffset = .init(x: .zero, y: heroesSeleсtingCollectionView.contentInset.top)
        case .bottom:
            contentOffset = .init(x: .zero, y: heroesSeleсtingCollectionView.bottomOffset)
        }

        heroesSeleсtingCollectionView.setContentOffset(contentOffset, animated: true)
    }
    
    func moveUpCell(with indexPath: IndexPath) {
        heroesSeleсtingCollectionView.performBatchUpdates {
            self.heroesSeleсtingCollectionView.moveItem(at: indexPath, to: .zero)
        } completion: { result in
            self.uiDelegate?.heroesListView(self, didMoveUpHeroWithAnimationResult: result)
        }
    }
    
    func setAlphaForCell(with indexPath: IndexPath, alpha: HeroCellAlpha) {
        heroesSeleсtingCollectionView.cellForItem(at: indexPath)?.alpha = CGFloat(alpha.value)
    }
    
    func setAlphaForEachVisibleCells(alpha: HeroCellAlpha) {
        heroesSeleсtingCollectionView.visibleCells.forEach { $0.alpha = CGFloat(alpha.value) }
    }
    
    private func setupUI() {
        addSubviews()
        setupAutoLayout()
    }
    
    private func addSubviews() {
        addSubview(heroesSeleсtingCollectionView)
        addSubview(launchActivityIndicatorView)
    }
    
    private func setupAutoLayout() {
        activateHeroesCollectionViewConstraints()
        activateLaunchActivityIndicatorViewConstraint()
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
    
    private func activateLaunchActivityIndicatorViewConstraint() {
        let subview = launchActivityIndicatorView
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - ActionDelegate

extension HeroesListView: HeroesSeleсtingCollectionViewActionDelegate {
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, didSelectHeroWith indexPath: IndexPath) {
        uiDelegate?.heroesListView(self, didSelectHeroWithIndexPath: indexPath)
    }
    
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, willDisplayHeroWith indexPath: IndexPath) {
        uiDelegate?.heroesListView(self, willDisplayHeroWithIndexPath: indexPath)
    }
}

// MARK: - DataSourceDelegate

extension HeroesListView: HeroesSeleсtingCollectionViewDataSourceDelegate {
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, getCellsCountOf reuseIdentifier: String) -> Int? {
        uiDelegate?.heroesListView(self, getCellsCountOf: reuseIdentifier)
    }
    
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, getHeroCellModelWith indexPath: IndexPath) -> HeroCellModel? {
        uiDelegate?.heroesListView(self, getHeroCellModelWithIndexPath: indexPath)
    }
}
