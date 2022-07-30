import UIKit

protocol HeroesListViewUiDelegate: AnyObject {
}

final class HeroesListView: UIView {
    
    weak var uiDelegate: HeroesListViewUiDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = AppColor.GlobalColor.background
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = AppColor.GlobalColor.background
    }
}
