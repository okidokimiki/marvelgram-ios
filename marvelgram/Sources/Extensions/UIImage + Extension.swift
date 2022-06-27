//
//  UIImage + Extension.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 08.06.2022.
//

import UIKit

extension UIImage {
    // MARK: - Initilization
    
    convenience init?(assets: Icon) {
        self.init(named: assets.rawValue)
    }
    
    // MARK: - Assets Image
    
    enum Icon: String {
        case marvellogo = "marvel-logo"
    }
}
