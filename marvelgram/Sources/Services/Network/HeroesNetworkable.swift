//
//  HeroesNetworkable.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 28.06.2022.
//

import Foundation

typealias JSONResponseHandler = (JSONResponse) -> Void

protocol HeroesNetworkable {
    func fetch<T: Codable>(of type: T.Type, completion: @escaping JSONResponseHandler)
    func fetchConfig<T: Codable>(of type: T.Type, completion: @escaping JSONResponseHandler)
}
