//
//  Font.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 08.06.2022.
//
//  Source: https://www.ramshandilya.com/blog/design-system-typography/

import UIKit

// MARK: - Font

enum Font: String {
    case normal = "SF-Pro"
    
    var name: String {
        return self.rawValue
    }
}

// MARK: - FontDescription

struct FontDescription {
    let font: Font
    let size: CGFloat
    let style: UIFont.TextStyle
}

// MARK: - TextStyle

enum TextStyle {
    case display1
    case display2
    case paragraph
}

extension TextStyle {
    private var fontDescription: FontDescription {
        switch self {
        case .display1:
            return FontDescription(font: .normal, size: 34, style: .largeTitle)
        case .display2:
            return FontDescription(font: .normal, size: 17, style: .title2)
        case .paragraph:
            return FontDescription(font: .normal, size: 14, style: .body)
        }
    }
    
    var font: UIFont {
        guard
            let font = UIFont(name: fontDescription.font.name, size: fontDescription.size)
        else {
            return UIFont.preferredFont(forTextStyle: fontDescription.style)
        }

        return UIFontMetrics(forTextStyle: fontDescription.style).scaledFont(for: font)
    }
}
