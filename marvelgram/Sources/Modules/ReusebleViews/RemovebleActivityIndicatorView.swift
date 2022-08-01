import UIKit

final class RemovebleActivityIndicatorView: UIActivityIndicatorView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    private func configure() {
        hidesWhenStopped = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
