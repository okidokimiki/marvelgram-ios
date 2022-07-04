//
//  HeroDetailsViewOutput.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import Foundation

protocol HeroDetailsViewOutput {
    // Initilization
    init(view: HeroDetailsViewInput, coordinator: HeroDetailsCoordinator)
    
    func handleAppearingView()
    func handleDidLayoutSubviews()
}
