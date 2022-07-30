import UIKit

extension UILabel {
    
    func addInterlineSpacing(spacingValue: CGFloat) {
        guard let textString = text else { return }
        
        let attributedString = NSMutableAttributedString(string: textString)
        let range = NSRange(location: .zero, length: attributedString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacingValue
        
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        attributedText = attributedString
    }
    
}
