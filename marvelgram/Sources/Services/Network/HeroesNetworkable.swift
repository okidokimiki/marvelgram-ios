//
//  HeroesNetworkable.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 28.06.2022.
//

import Foundation

typealias JSONResponseHandler = (JSONResponse) -> Void

protocol HeroesNetworkable {
    func fetchHeroes(completion: @escaping JSONResponseHandler)
    func fetchHeroesConfig(completion: @escaping JSONResponseHandler)
}
