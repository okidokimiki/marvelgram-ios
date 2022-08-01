import UIKit

extension CGRect {
    
    func dividedIntegral(fraction: CGFloat, from fromEdge: CGRectEdge) -> (first: CGRect, second: CGRect) {
        let dimension: CGFloat
        
        switch fromEdge {
        case .minXEdge, .maxXEdge:
            dimension = size.width
        case .minYEdge, .maxYEdge:
            dimension = size.height
        }
        
        let distance = (dimension * fraction).rounded(.up)
        var slices = divided(atDistance: distance, from: fromEdge)
        
        /* Problems:
         1. when calling this method, you cannot expect that there will be margins here
         2. what to do if I want other margins? */
        
        // Margins
        switch fromEdge {
        case .minXEdge, .maxXEdge:
            slices.remainder.origin.x += 1
            slices.remainder.size.width -= 1
        case .minYEdge, .maxYEdge:
            slices.remainder.origin.y += 1
            slices.remainder.size.height -= 1
        }
        
        return (first: slices.slice, second: slices.remainder)
    }
}
