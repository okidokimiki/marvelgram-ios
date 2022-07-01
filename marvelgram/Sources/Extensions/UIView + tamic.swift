//
//  UIView + tamic.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 27.06.2022.
//

import UIKit

extension UIView {
    // MARK: - Public Methods
    
    func setupView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}
