//
//  UIColor + ext.swift
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
    
    // MARK: - ColorAssets
    
    enum Color: String {
        case background
        case accent
        case title
    }
}
