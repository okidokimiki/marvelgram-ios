//
//  BackBarButtonItem.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 06.07.2022.
//

import UIKit

class BackBarButtonItem: UIBarButtonItem {
    // MARK: - Initilization
    
    override init() {
        super.init()
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        title = .none
        tintColor = Palette.GlobalColor.fontPrimary
    }
}
