//
//  Photo.swift
//  ProofOfConcepts
//
//  Created by Avinash Patel on 4/19/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    var title: String?
    var description: String?
    var imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageUrl = "imageHref"
    }
}
