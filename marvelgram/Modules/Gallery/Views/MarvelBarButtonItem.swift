//
//  MarvelBarButtonItem.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 08.06.2022.
//

import UIKit

class MarvelBarButtonItem: UIBarButtonItem {
    // MARK: - Initilization
    
    override init() {
        super.init()
        
        configureBarButtonItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureBarButtonItem() {
        image = UIImage(image: .marvellogo)
        tintColor = UIColor(color: .title1)
        style = .plain
        target = self
        action = #selector(didTapMarvelButton(sender:))
    }
    
    // MARK: - Actions
    
    @objc private func didTapMarvelButton(sender: UIBarButtonItem) {
        print("didTapMarvelButton")
    }
}
