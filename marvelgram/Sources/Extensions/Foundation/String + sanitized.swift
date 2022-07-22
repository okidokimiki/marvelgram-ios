//
//  String + sanitized.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 22.07.2022.
//

import Foundation

extension String {
    // MARK: - Methods
    
    func sanitized(with removable: [String]) -> String {
        var sanitizedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        removable.forEach { sanitizedString = sanitizedString.replacingOccurrences(of: $0, with: "") }
        
        return sanitizedString.lowercased()
    }
}
