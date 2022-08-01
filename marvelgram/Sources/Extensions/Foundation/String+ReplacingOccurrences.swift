extension String {
    
    func replacingOccurrences(with removable: Set<String>) -> String {
        var sanitizedString = trimmingCharacters(in: .whitespacesAndNewlines)
        removable.forEach { sanitizedString = sanitizedString.replacingOccurrences(of: $0, with: "") }
        
        return sanitizedString.lowercased()
    }
}
