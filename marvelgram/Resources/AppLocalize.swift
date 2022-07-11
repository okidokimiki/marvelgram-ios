//
//  Localization.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 14.06.2022.
//

import Foundation

enum AppLocalize: String {
    // HeroesList
    case searchPlaceholderText = "searchPlaceholder.text"
    // HeroDetails
    case exploreMoreTitle = "exploreMore.title"
    case descriptionText = "description.text"
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
