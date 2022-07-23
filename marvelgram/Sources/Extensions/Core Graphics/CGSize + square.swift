//
//  CGSize + square.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 23.07.2022.
//

import UIKit

extension CGSize {
    // MARK: - Static Methods
    
    static func square(with size: CGFloat) -> CGSize {
        return self.init(width: size, height: size)
    }
}
