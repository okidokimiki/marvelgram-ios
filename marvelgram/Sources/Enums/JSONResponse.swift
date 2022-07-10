//
//  JSONResponse.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 27.06.2022.
//

enum JSONResponse {
    case success(_ response: Any)
    case error(_ error: NetworkError)
}
