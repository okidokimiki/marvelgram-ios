//
//  ReuseIdentifiable.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 01.07.2022.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
