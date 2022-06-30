//
//  DetailViewOutput.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import Foundation

protocol DetailViewOutput {
    init(view: DetailViewInput, dataSource: DetailDataSource)
}
