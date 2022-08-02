/*
 I don`t know how to make such an Instagram layout. But I found such a solution from Apple`s website:
 https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/layouts/customizing_collection_view_layouts
 
 They don`t consider the option with three equal cells in a row (look at cells by number №3, 4, 5 and 9, 10, 11).
 So, I found a similar solution and fixed it a bit.
 
 :
 
        InstaGrid               Segments             Mosaic`s parts
 ╔═════════════╦══════╗ +--------------------+ +----------------------+
 ║             ║   1  ║ |                    | |                      |
 ║             ║      ║ |                    | |                      |
 ║      0      ╠══════╣ | .twoThirdsOneThird | |         1 /          |
 ║             ║   2  ║ |                    | |          /           |
 ║             ║      ║ |                    | |         / 2          |
 ╠══════╦══════╬══════╣ +--------------------+ |                      |
 ║   5  ║   4  ║   3  ║ |   .tripleOneThird  | | isHalfMosaic = true  |
 ║      ║      ║      ║ |                    | |                      |
 ╠══════╬══════╩══════╣ +--------------------+ +----------------------+
 ║   6  ║             ║ |                    | |                      |
 ║      ║             ║ |                    | |                      |
 ╠══════╣      8      ║ | .oneThirdTwoThirds | |         2 /          |
 ║   7  ║             ║ |                    | |          /           |
 ║      ║             ║ |                    | |         / 2          |
 ╠══════╬══════╦══════╣ +--------------------+ |                      |
 ║  11  ║  10  ║   9  ║ |   .tripleOneThird  | | isHalfMosaic = false |
 ║      ║      ║      ║ |                    | |                      |
 ╚══════╩══════╩══════╝ +--------------------+ +----------------------+ */

import UIKit

enum MosaicSegmentStyle {
    /// 2/3 + 1/3
    case twoThirdsOneThird
    /// 1/3 + 1/3 + 1/3
    case tripleOneThird
    /// 1/3 + 2/3
    case oneThirdTwoThirds
}

final class InstaGridFlowLayout: UICollectionViewFlowLayout {
    
    private var cachedAttributes: [UICollectionViewLayoutAttributes] = []
    private var contentBounds = CGRect()
    private var isHalfMosaic = Bool()
    
    override var collectionViewContentSize: CGSize {
        contentBounds.size
    }
    
    override func prepare() {
        super.prepare()
        
        // - Preparation
        guard let collectionView = collectionView else { return }
        let cvItemsCount = collectionView.numberOfItems(inSection: .zero)
        let cvWidth = collectionView.bounds.size.width
        
        cachedAttributes.removeAll()
        contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)
        
        var lastFrame: CGRect = .zero
        var currentIndex: Int = .zero
        var nextSegment: MosaicSegmentStyle = .twoThirdsOneThird
        
        while currentIndex < cvItemsCount {
            var segmentRects: [CGRect] = []
            let segmentFrame = CGRect(x: 0.0, y: lastFrame.maxY + 1.0, width: cvWidth, height: (2.0 / 3.0) * cvWidth)
            
            // - Layout
            switch nextSegment {
            case .twoThirdsOneThird:
                let horizontalSlices = segmentFrame.dividedIntegral(fraction: (2.0 / 3.0), from: .minXEdge)
                let verticalSlices = horizontalSlices.second.dividedIntegral(fraction: 0.5, from: .minYEdge)
                segmentRects = [horizontalSlices.first, verticalSlices.first, verticalSlices.second]
            case .tripleOneThird:
                let size = segmentFrame.width / 3.0 - 1.0
                let side = CGSize(side: size)
                
                let rect1 = CGRect(origin: CGPoint(x: segmentFrame.width - size, y: lastFrame.maxY + 1), size: side)
                let rect2 = CGRect(origin: CGPoint(x: rect1.minX - 1 - size, y: lastFrame.maxY + 1), size: side)
                let rect3 = CGRect(origin: CGPoint(x: rect2.minX - 1 - size, y: lastFrame.maxY + 1), size: side)
                segmentRects = [rect1, rect2, rect3]
            case .oneThirdTwoThirds:
                let horizontalSlices = segmentFrame.dividedIntegral(fraction: (1.0 / 3.0), from: .minXEdge)
                let verticalSlices = horizontalSlices.first.dividedIntegral(fraction: 0.5, from: .minYEdge)
                segmentRects = [verticalSlices.first, verticalSlices.second, horizontalSlices.second]
            }
            
            for rect in segmentRects {
                let indexPath = IndexPath(item: currentIndex, section: .zero)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = rect
                
                cachedAttributes.append(attributes)
                contentBounds = contentBounds.union(lastFrame)
                
                currentIndex += 1
                lastFrame = rect
            }
            
            // - Switching
            switch nextSegment {
            case .twoThirdsOneThird:
                nextSegment = .tripleOneThird
                isHalfMosaic = true
            case .tripleOneThird:
                nextSegment = isHalfMosaic ? .oneThirdTwoThirds : .twoThirdsOneThird
            case .oneThirdTwoThirds:
                nextSegment = .tripleOneThird
                isHalfMosaic = false
            }
            
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray: [UICollectionViewLayoutAttributes] = []
        
        guard let lastIndex = cachedAttributes.indices.last,
              let firstMatchIndex = binSearch(rect, start: .zero, end: lastIndex) else { return attributesArray }
        
        for attributes in cachedAttributes[..<firstMatchIndex].reversed() {
            guard attributes.frame.maxY >= rect.minY else { break }
            attributesArray.append(attributes)
        }
        
        for attributes in cachedAttributes[firstMatchIndex...] {
            guard attributes.frame.minY <= rect.maxY else { break }
            attributesArray.append(attributes)
        }
        
        return attributesArray
    }
    
    private func binSearch(_ rect: CGRect, start: Int, end: Int) -> Int? {
        if end < start { return nil }
        
        let mid = (start + end) / 2
        let attr = cachedAttributes[mid]
        
        if attr.frame.intersects(rect) {
            return mid
        } else {
            if attr.frame.maxY < rect.minY {
                return binSearch(rect, start: (mid + 1), end: end)
            } else {
                return binSearch(rect, start: start, end: (mid - 1))
            }
        }
    }
    
}
