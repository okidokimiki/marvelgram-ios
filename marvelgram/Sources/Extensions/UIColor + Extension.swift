//
//  UIColor + Extension.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

extension UIColor {
    // MARK: - Initilization
    
    convenience init?(assets: Color) {
        self.init(named: assets.rawValue)
    }
    
    // MARK: - Assets Color
    
    enum Color: String, CaseIterable {
        case accent1
        case background
        case title1
    }
}
