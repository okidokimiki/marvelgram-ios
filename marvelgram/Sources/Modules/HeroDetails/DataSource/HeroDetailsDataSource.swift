//
//  HeroDetailsDataSource.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 29.06.2022.
//

import Foundation

final class HeroDetailsDataSource {
    var heroSeleсtingCellModel: HeroCellModel?
    var otherCharCellModels: [HeroCellModel]?
    
    init(heroSeleсtingCellModel: HeroCellModel?, otherCharCellModels: [HeroCellModel]?) {
        self.heroSeleсtingCellModel = heroSeleсtingCellModel
        self.otherCharCellModels = otherCharCellModels
    }
}
