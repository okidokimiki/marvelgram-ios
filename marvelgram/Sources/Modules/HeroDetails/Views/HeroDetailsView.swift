import UIKit

protocol HeroDetailsViewUiDelegate: AnyObject {
}

final class HeroDetailsView: UIView {
    
    weak var uiDelegate: HeroDetailsViewUiDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = AppColor.GlobalColor.background
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = AppColor.GlobalColor.background
    }
}
