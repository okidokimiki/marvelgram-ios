//
//  Fetchable.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 04.07.2022.
//

import Foundation

protocol Fetchable {
    func fetch<T: Codable>(with urlString: String, of type: T.Type, completion: @escaping JSONResponseHandler)
    func fetchConfig<T: Codable>(with urlString: String, of type: T.Type, completion: @escaping JSONResponseHandler)
}
