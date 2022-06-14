//
//  FontSize.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 12.06.2022.
//

import UIKit

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
