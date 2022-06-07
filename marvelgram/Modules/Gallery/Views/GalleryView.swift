//
//  GalleryView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

class GalleryView: UIView {
    // MARK: - Public Properties
    
    weak var uiDelegate: GalleryViewUiDelegate?
    
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        backgroundColor = UIColor(color: .background)
    }
}
