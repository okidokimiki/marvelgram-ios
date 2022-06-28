//
//  Localization.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 14.06.2022.
//

import Foundation

enum Localization: String {
    case exploreMoreTitle = "exploreMore.title"
    case spideySubtitle = "spidey.subtitle"
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
