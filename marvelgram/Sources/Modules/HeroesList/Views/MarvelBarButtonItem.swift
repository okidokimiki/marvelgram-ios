//
//  MarvelBarButtonItem.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 08.06.2022.
//

import UIKit

protocol NavBarButtonItemUiDelegate: AnyObject {
    func navBarButtonItem(_ navBarButtonItem: UIBarButtonItem, didTapNavBarButtonWithType type: NavBarButtonType)
}

final class MarvelBarButtonItem: UIBarButtonItem {
    // MARK: - Properties
    
    weak var uiDelegate: NavBarButtonItemUiDelegate?
    
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
        image = UIImage(assets: .marvellogo)
        tintColor = AppColor.GlobalColor.font
        style = .plain
        target = self
        action = #selector(didTapMarvelButton)
    }
}

// MARK: - Actions

@objc
private extension MarvelBarButtonItem {
    func didTapMarvelButton() {
        uiDelegate?.navBarButtonItem(self, didTapNavBarButtonWithType: .marvel)
    }
}
