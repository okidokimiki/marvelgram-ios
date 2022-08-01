import Foundation

protocol HeroesListViewInput: AnyObject {
    func reloadCollectionView()
    func showLaunchActivityIndicator(_ show: Bool)
    func scrollCollectionView(to direction: ScrollDirection)
    func moveUpCell(with indexPath: IndexPath)
    func setAlphaForEachVisibleCells(alpha: HeroCellAlpha)
    func setAlphaForCell(with indexPath: IndexPath, alpha: HeroCellAlpha)
    func updateFlowLayout(with type: FlowLayoutType)
}

enum ScrollDirection {
    case top
    case bottom
}

enum HeroCellAlpha: Double {
    case clear = 1.0
    case muddy = 0.3
    
    var value: Double { rawValue }
}

enum FlowLayoutType {
    /// DefaultGrid
    case grid
    /// InstaGrid
    case insta
}
