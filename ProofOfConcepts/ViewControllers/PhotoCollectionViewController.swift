//
//  PhotoCollectionViewController.swift
//  ProofOfConcepts
//
//  Created by Avinash Patel on 4/18/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {

    override func loadView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: 50, height: 50)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        if let patternImage = UIImage(named: "pattern.png") {
            self.view.backgroundColor = UIColor(patternImage: patternImage)
        }
        self.collectionView.backgroundColor = .clear
    }
}
