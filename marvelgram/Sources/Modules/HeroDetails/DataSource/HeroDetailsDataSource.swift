//
//  HeroDetailsDataSource.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 29.06.2022.
//

final class HeroDetailsDataSource {
    var heroSeleсtingCellModel: HeroSeleсtingCellModel?
    var otherCharCellModels: [HeroSeleсtingCellModel]?
    
    init(heroSeleсtingCellModel: HeroSeleсtingCellModel?, otherCharCellModels: [HeroSeleсtingCellModel]?) {
        self.heroSeleсtingCellModel = heroSeleсtingCellModel
        self.otherCharCellModels = otherCharCellModels
    }
}
