//
//  HeroCellAlpha.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 19.07.2022.
//

import Foundation

enum HeroCellAlpha: Double {
    case clear = 1.0
    case muddy = 0.3
    
    var value: Double {
        return self.rawValue
    }
}
