//
//  FlexibleHeighyLayout.swift
//  CustomCollectionViewLayout
//
//  Created by JunHeeJo on 2/2/22.
//

import UIKit
import CoreLocation


// MARK: - Delegate
protocol FlexibleHeightLayoutDelegate: AnyObject {
    func collecionView(_ collectionView: UICollectionView, heightForIndexPath indexPath: IndexPath) -> CGFloat
    
    func numberOfColumns(_ collectionView: UICollectionView) -> Int
}


// MARK: - FlexibleHeightLayout
class FlexibleHeightLayout: UICollectionViewLayout {
    weak var delegate: FlexibleHeightLayoutDelegate?
    
    private var numberOfColumns: Int {
        guard let collectionView = collectionView else {
            return 2
        }
        
        return delegate?.numberOfColumns(collectionView) ?? 2
    }
    
    private var interItemSpacing: CGFloat = 0
    private var lineSpacing: CGFloat = 0
    
    var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentsHeight: CGFloat = 0
    private var contentsWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        
        let inset = collectionView.contentInset
        
        return collectionView.bounds.width - (inset.left + inset.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentsWidth, height: contentsHeight)
    }
    
    func setInterItemSpacing(_ spacing: CGFloat) {
        self.interItemSpacing = spacing
    }
    
    func setLineSpacing(_ spacing:CGFloat) {
        self.lineSpacing = spacing
    }
    
    override func prepare() {
        guard cache.isEmpty,
              let collectionView = collectionView else {
                  return
              }
        
        let width: CGFloat = contentsWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        
        for column in 0...numberOfColumns {
            xOffset.append(CGFloat(column) * width)
        }
        
        var column: Int = 0
        var yOffset: [CGFloat] = [CGFloat].init(repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath: IndexPath = IndexPath(item: item, section: 0)
            
            let collectionViewHeigt = collectionView.frame.height
            
            
            // MARK: - todo
            let textHeight: CGFloat = delegate?.collecionView(collectionView, heightForIndexPath: indexPath) ?? collectionViewHeigt / 4
            
            let height = textHeight + (lineSpacing * 2)
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: width, height: height)
            let insetFrame = frame.insetBy(dx: interItemSpacing, dy: lineSpacing)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentsHeight = max(contentsHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attribute in cache {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }
        
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
