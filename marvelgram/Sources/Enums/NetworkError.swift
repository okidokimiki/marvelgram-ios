//
//  NetworkError.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 27.06.2022.
//

import Foundation

enum NetworkError: Error {
    case noData
    case invalidURL
    case decodingError
    case badResponse(URLResponse?)
}
