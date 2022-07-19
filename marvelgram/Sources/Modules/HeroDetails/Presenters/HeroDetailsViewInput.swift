//
//  HeroDetailsViewInput.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import Foundation

protocol HeroDetailsViewInput: AnyObject {
    func updateUI(with model: HeroCellModel?)
    func finishLayoutSubviews()
}
