//
//  Typography.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 08.06.2022.
//

import UIKit

enum Typography {
    /// pt34, sfProRegular
    case display1
    /// pt17, sfProRegular
    case display2
    /// pt14, sfProRegular
    case paragraph
    
    var value: UIFont? {
        switch self {
        case .display1:
            return UIFont.makeFontWith(name: .sfProRegular, size: .pt34)
        case .display2:
            return UIFont.makeFontWith(name: .sfProRegular, size: .pt17)
        case .paragraph:
            return UIFont.makeFontWith(name: .sfProRegular, size: .pt14)
        }
    }
}
