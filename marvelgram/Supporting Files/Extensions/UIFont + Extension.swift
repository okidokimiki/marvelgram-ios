//
//  UIFont + Extension.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 12.06.2022.
//

import UIKit

extension UIFont {
    // MARK: - Public Methods
    
    static func makeFontWith(title: FontTitle, size: FontSize) -> UIFont? {
        return UIFont(name: title.name, size: size.value)
    }
}
