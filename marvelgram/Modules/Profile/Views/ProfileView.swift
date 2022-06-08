//
//  ProfileView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

class ProfileView: UIView {
    // MARK: - Public Properties
    
    weak var uiDelegate: ProfileViewUiDelegate?
    
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
