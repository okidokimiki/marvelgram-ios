//
//  UILabel + interlineSpacing.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 04.07.2022.
//

import UIKit

extension UILabel {
    // MARK: - Methods
    
    func addInterlineSpacing(spacingValue: CGFloat = 2) {
        guard let textString = text else { return }
        
        let attributedString = NSMutableAttributedString(string: textString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacingValue
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: attributedString.length))
        attributedText = attributedString
    }
    
}
