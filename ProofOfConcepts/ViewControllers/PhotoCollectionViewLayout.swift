//
//  PhotoCollectionViewLayout.swift
//  ProofOfConcepts
//
//  Created by Avinash Patel on 4/19/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

protocol PhotoCollectionViewLayoutDelegate: class {
    // Method to ask the delegate for the Data to display
    func getCollectionViewData(_ collectionView:UICollectionView) -> [Photo]?
}

class PhotoCollectionViewLayout: UICollectionViewLayout {
    // PhotoCollectionView Layout Delegate
    weak var delegate: PhotoCollectionViewLayoutDelegate!
    
    // Configurable properties
    private var columnWidth: CGFloat = Constants.photoWidth
    private var cellPadding: CGFloat = Constants.cellPadding
    
    // Array to keep a cache of attributes.
    private var cache = [UICollectionViewLayoutAttributes]()
    
    // Content height and size
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        cache.removeAll()
        guard let collectionView = collectionView, self.delegate != nil else {
            return
        }
        guard let photos = delegate.getCollectionViewData(collectionView) else { return }
        // Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
        let photoHeight: CGFloat = self.columnWidth
        
        // Calculating numberOfColumns from the available screen width which depends on the orientation of the device
        // Multiplying cellPadding with four to leave minimum space between columns
        var numberOfColumns = Int((contentWidth - 4 * cellPadding) / columnWidth)
        
        // Calculating cellPadding(space between columns) based on width and numberOfColumns
        var cellPaddingX = (contentWidth - CGFloat(numberOfColumns * Int(columnWidth))) / CGFloat(numberOfColumns + 1)
        
        // Minimum CellPadding(space between columns) Required
        let minCellPaddingX: CGFloat = 10.0
        
        // If available space between columns is less than 10 than reducing numberOfColumns by one
        if cellPaddingX < minCellPaddingX {
            numberOfColumns -= 1
            cellPaddingX = (contentWidth - CGFloat(numberOfColumns * Int(columnWidth))) / CGFloat(numberOfColumns + 1)
        }
        var yOffset = [CGFloat]()
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
            yOffset.append(0)
        }
        var column = 0
        
        // Iterates through the list of items in the first section
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            let titleLabelHeight = photos[indexPath.item].title?.height(constraintedWidth: columnWidth, font: Constants.Font.titleBold) ?? 0
            let descriptionLabelHeight = photos[indexPath.item].description?.height(constraintedWidth: columnWidth, font: Constants.Font.body) ?? 0
            
            let height: CGFloat = photoHeight + titleLabelHeight + descriptionLabelHeight
            let frame = CGRect(x: xOffset[column] + CGFloat(column + 1) * cellPaddingX, y: yOffset[column] + cellPadding, width: columnWidth, height: height)
            
            // Creates an UICollectionViewLayoutItem with the frame and add it to the cache
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            // Updates the collection view content height
            yOffset[column] = yOffset[column] + height + cellPadding + 5
            let descendingYOffset = yOffset.sorted(by: >)
            let maxY_Offset = descendingYOffset.first ?? 0
            // Top space to be left above the cells
            let cellPaddingY: CGFloat = 50
            contentHeight = maxY_Offset + cellPaddingY
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
}
