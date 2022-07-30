import UIKit

protocol NavBarButtonItemDelegate: AnyObject {
    func navBarButtonItem(_ navBarButtonItem: UIBarButtonItem, didTapNavBarButtonWithType type: NavBarButtonType)
}

final class MarvelBarButtonItem: UIBarButtonItem {
    
    weak var delegate: NavBarButtonItemDelegate?
    
    override init() {
        super.init()
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    private func configure() {
        image = UIImage(assets: .marvellogo)
        tintColor = AppColor.GlobalColor.font
        style = .plain
        target = self
        action = #selector(didTapMarvelButton)
    }
}

// MARK: - Actions

@objc
private extension MarvelBarButtonItem {
    func didTapMarvelButton() {
        delegate?.navBarButtonItem(self, didTapNavBarButtonWithType: .marvel)
    }
}
