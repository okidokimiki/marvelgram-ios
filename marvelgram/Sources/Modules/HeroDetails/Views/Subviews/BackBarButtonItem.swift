import UIKit

final class BackBarButtonItem: UIBarButtonItem {
    
    override init() {
        super.init()
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    private func configure() {
        title = nil
        tintColor = AppColor.GlobalColor.font
    }
}
