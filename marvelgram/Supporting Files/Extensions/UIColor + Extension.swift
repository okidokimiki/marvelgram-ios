//
//  UIColor + Extension.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

extension UIColor {
    // MARK: - Initilization
    
    convenience init?(color: Color) {
        self.init(named: color.rawValue)
    }
    
    // MARK: - Assets Color
    
    enum Color: String, CaseIterable {
        case background
        case cellBackground
    }
}
