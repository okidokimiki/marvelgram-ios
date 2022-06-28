//
//  ImageCache.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

final class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
            
    private init() {}
}
