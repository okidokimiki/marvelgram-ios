//
//  HeroesRepositorieble.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 28.06.2022.
//

import Foundation

typealias HeroConfigResponseHandler = ([Hero]) -> Void

protocol HeroesRepositorieble {
    func getHeroes(completion: @escaping HeroConfigResponseHandler)
}
