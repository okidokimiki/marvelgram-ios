//
//  Networkable.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 28.06.2022.
//

import Foundation

typealias JSONResponseHandler = (JSONResponse) -> Void

protocol Networkable: Fetchable { }
