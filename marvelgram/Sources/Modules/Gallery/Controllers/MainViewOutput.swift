//
//  MainViewOutput.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

protocol MainViewOutput {
    init(view: MainViewInput, dataSource: MainDataSource)
    
    func handleDidAppearingView()
    
    func getHeroCellModelsCount() -> Int?
    func getHeroCellModel(with index: Int) -> HeroCellModel
}
