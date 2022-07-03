//
//  Localization.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 14.06.2022.
//

import Foundation

enum Localization: String {
    case exploreMoreTitle = "exploreMore.title"
    case descriptionErrorText = "descriptionError.text"
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
