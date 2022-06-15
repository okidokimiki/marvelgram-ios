//
//  UIFont + Extension.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 12.06.2022.
//

import UIKit

extension UIFont {
    // MARK: - Public Methods
    
    static func makeFontWith(name: FontName, size: FontSize) -> UIFont? {
        return UIFont(name: name.value, size: size.value)
    }
}
