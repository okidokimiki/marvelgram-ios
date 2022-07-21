//
//  HeroCellModel.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

struct HeroCellModel: Equatable {
    let name: String
    let description: String
    let url: String
    
    init(hero: Hero) {
        self.name = hero.name
        self.description = hero.description
        self.url = hero.thumbnail.path + "." + hero.thumbnail.`extension`
    }
}
