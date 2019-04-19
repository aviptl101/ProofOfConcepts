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
    
}
