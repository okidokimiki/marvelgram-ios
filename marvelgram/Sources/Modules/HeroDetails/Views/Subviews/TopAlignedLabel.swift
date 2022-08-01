import UIKit

final class TopAlignedLabel: UILabel {
    /* It looks like a «crutch», but it solves the problem:
     Without this code, the text will be aligned in the middle horizontally */
    
    override func drawText(in rect: CGRect) {
        let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: textRect)
    }
}
