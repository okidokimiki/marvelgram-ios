import Foundation

protocol HeroesListViewInput: AnyObject {
    func reloadCollectionView()
    func showLaunchActivityIndicator(_ show: Bool)
    func scrollCollectionView(to direction: ScrollDirection)
    func moveUpCell(with indexPath: IndexPath)
}

enum ScrollDirection {
    case top
    case bottom
}
