//
//  Hero.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

struct Hero: Codable {
    var id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: Thumbnail
}

// MARK: - Thumbnail

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
}
