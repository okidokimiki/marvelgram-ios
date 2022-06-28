//
//  Hero.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

// MARK: - Hero

struct Hero: Codable, Equatable {
    var id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: Thumbnail
}

// MARK: - Thumbnail

struct Thumbnail: Codable, Equatable {
    let path: String
    let `extension`: String
}
