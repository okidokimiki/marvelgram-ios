//
//  LocalizableStrings.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 14.06.2022.
//

import Foundation

enum LocalizableStrings: String {
    case exploreMoreTitle = "exploreMore.title"
    case spideySubtitle = "spidey.subtitle"
    
    // MARK: - localizedString
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
