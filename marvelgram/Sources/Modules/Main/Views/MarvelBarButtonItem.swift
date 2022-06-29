//
//  MarvelBarButtonItem.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 08.06.2022.
//

import UIKit

final class MarvelBarButtonItem: UIBarButtonItem {
    // MARK: - Initilization
    
    override init() {
        super.init()
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        image = UIImage(assets: .marvellogo)
        tintColor = UIColor(assets: .title)
        style = .plain
        target = self
        action = #selector(didTapMarvelButton(sender:))
    }
}

// MARK: - Actions

@objc
private extension MarvelBarButtonItem {
    func didTapMarvelButton(sender: UIBarButtonItem) {
        print("didTapMarvelButton")
    }
}
