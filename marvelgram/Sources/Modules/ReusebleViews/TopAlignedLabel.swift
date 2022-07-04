//
//  TopAlignedLabel.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 04.07.2022.
//

import UIKit

class TopAlignedLabel: UILabel {
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Override Methods
    
    override func drawText(in rect: CGRect) {
        let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: textRect)
    }
}
