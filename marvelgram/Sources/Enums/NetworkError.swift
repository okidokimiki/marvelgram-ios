//
//  NetworkError.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 27.06.2022.
//

import Foundation

enum NetworkError: Error {
    case dataIsNil
    case invalidURL
    case invalidData
    case decodingError
    case badResponse(URLResponse?)
}
