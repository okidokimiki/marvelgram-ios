import UIKit

extension UIImage {
    
    convenience init?(assets: Images) {
        self.init(named: assets.rawValue)
    }
    
    enum Images: String {
        case marvellogo = "marvel-logo"
    }
}
