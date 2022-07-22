//
//  InstaGridFlowLayout.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 22.07.2022.
//

/* InstaGrid
 ╔═════════════╦══════╗
 ║             ║   1  ║
 ║             ║      ║
 ║      0      ╠══════╣
 ║             ║   2  ║
 ║             ║      ║
 ╠══════╦══════╬══════╣
 ║   3  ║   4  ║   5  ║
 ║      ║      ║      ║
 ╠══════╬══════╩══════╣
 ║   6  ║             ║
 ║      ║             ║
 ╠══════╣      7      ║
 ║   ?  ║             ║
 ║      ║             ║
 ╠══════╬══════╦══════╣
 ║   ?  ║   ?  ║   ?  ║
 ║      ║      ║      ║
 ╚══════╩══════╩══════╝
 */

import UIKit

final class InstaGridFlowLayout: UICollectionViewFlowLayout {
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
        
    }
}

// MARK: - Constants

private extension InstaGridFlowLayout {
    enum Constants {
    }
}
