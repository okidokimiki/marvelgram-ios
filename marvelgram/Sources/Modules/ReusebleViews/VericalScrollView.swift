//
//  VericalScrollView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 05.07.2022.
//

import UIKit

class VericalScrollView: UIScrollView {
    // MARK: - Override Properties
    
    override var contentOffset: CGPoint {
        get {
            return super.contentOffset
        }
        set {
            super.contentOffset = CGPoint(x: 0, y: newValue.y)
        }
    }
    
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
}
