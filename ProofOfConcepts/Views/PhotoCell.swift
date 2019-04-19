//
//  PhotoCell.swift
//  ProofOfConcepts
//
//  Created by Avinash Patel on 4/19/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    private let cellImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.titleBold
        label.textColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.body
        label.textColor = .white
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
