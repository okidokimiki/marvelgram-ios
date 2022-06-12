//
//  Font.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 08.06.2022.
//

import UIKit

// MARK: - Font

enum Font {
    case display1
    case display2
    case paragraph
    
    var type: UIFont? {
        switch self {
        case .display1:
            return UIFont.makeFontWith(title: .sfPro, size: .pt34)
        case .display2:
            return UIFont.makeFontWith(title: .sfPro, size: .pt17)
        case .paragraph:
            return UIFont.makeFontWith(title: .sfPro, size: .pt14)
        }
    }
}

// MARK: - FontTitle

enum FontTitle: String {
    case sfPro = "SF-Pro"

    var name: String {
        return self.rawValue
    }
}

// MARK: - FontSize

enum FontSize: CGFloat {
    case pt34
    case pt17
    case pt14
    
    var value: CGFloat {
        switch self {
        case .pt34:
            return 34
        case .pt17:
            return 17
        case .pt14:
            return 14
        }
    }
}
