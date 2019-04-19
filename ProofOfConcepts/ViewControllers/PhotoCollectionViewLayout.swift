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
