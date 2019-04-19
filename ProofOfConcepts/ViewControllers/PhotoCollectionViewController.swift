//
//  PhotoCollectionViewController.swift
//  ProofOfConcepts
//
//  Created by Avinash Patel on 4/18/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "PhotoCell"
    
    private var  photosViewModel: PhotosViewModel?
    
    private let NoDataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "No Data Available"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let refreshControl = UIRefreshControl()
    
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

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
        self.activityIndicator.color = .white
        let font = UIFont.preferredFont(forTextStyle: .caption1)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black,
            ]
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
        self.setupCollectionView()
        self.setAutolayoutConstraints()
    }
    
    // MARK: Private Methods
    
    func setupCollectionView() {
        self.collectionView.addSubview(self.activityIndicator)
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        self.collectionView.backgroundColor = .clear
        self.collectionView.refreshControl = self.refreshControl
        
        // Register cell classes
        self.collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func setAutolayoutConstraints() {
        // Autolayout constraints
        self.view.addSubview(NoDataLabel)
        self.NoDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.NoDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
