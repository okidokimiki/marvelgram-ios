//
//  Typography.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 08.06.2022.
//

import UIKit

enum Typography {
    /// pt34, sfPro
    case display1
    /// pt17, sfPro
    case display2
    /// pt14, sfPro
    case paragraph
    
    var value: UIFont? {
        switch self {
        case .display1:
            return UIFont.makeFontWith(name: .sfPro, size: .pt34)
        case .display2:
            return UIFont.makeFontWith(name: .sfPro, size: .pt17)
        case .paragraph:
            return UIFont.makeFontWith(name: .sfPro, size: .pt14)
        }
    }
}
