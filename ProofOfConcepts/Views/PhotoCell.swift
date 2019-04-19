//
//  PhotoCell.swift
//  ProofOfConcepts
//
//  Created by Avinash Patel on 4/19/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit
import SDWebImage

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
    
    func configureCellView() {
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        self.setAutoLayoutConstraints()
    }
    
    func setAutoLayoutConstraints() {
        let labelStackView = UIStackView(arrangedSubviews: [self.titleLabel, self.descriptionLabel])
        labelStackView.axis = .vertical
        labelStackView.distribution = .fill
        labelStackView.alignment = .center
        labelStackView.spacing = 5
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.cellImageView)
        self.contentView.addSubview(labelStackView)
        
        // ImageView Autolayout Constraints
        self.cellImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.cellImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        self.cellImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.cellImageView.widthAnchor.constraint(equalToConstant: 200)
        self.cellImageView.heightAnchor.constraint(equalToConstant: 200)
        self.cellImageView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)
        self.cellImageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        // Labels Autolayout Constraints
        self.descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        labelStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        labelStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        labelStackView.topAnchor.constraint(equalTo: self.cellImageView.bottomAnchor).isActive = true
        labelStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    func configure(with photo: Photo) {
        self.titleLabel.text = photo.title ?? ""
        self.descriptionLabel.text = photo.description ?? ""
        self.cellImageView.sd_setImage(with: URL(string: photo.imageUrl ?? ""), placeholderImage: UIImage(named: "place_holder.png"))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellImageView.image = nil
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
    }
}
