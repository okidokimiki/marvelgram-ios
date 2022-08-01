import UIKit

protocol HeroesListViewUiDelegate: AnyObject {
    // DataSource
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
