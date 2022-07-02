//
//  UIImage + assets.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 08.06.2022.
//

import UIKit

extension UIImage {
    // MARK: - Initilization
    
    convenience init?(assets: Images) {
        self.init(named: assets.rawValue)
    }
    
    // MARK: - Assets
    
    enum Images: String {
        case marvellogo = "marvel-logo"
    }
}
