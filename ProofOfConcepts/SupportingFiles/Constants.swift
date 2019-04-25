//
//  Constants.swift
//  ProofOfConcepts
//
//  Created by Avinash Patel on 4/19/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit
import Foundation

struct Constants {
    static let photoWidth: CGFloat = 160
    static let cellPadding: CGFloat = 10
    
    struct Font {
        static let body = UIFont.systemFont(ofSize: 15)
        static let bodyBold = UIFont.boldSystemFont(ofSize: 15)
        static let title = UIFont.systemFont(ofSize: 19)
        static let titleBold = UIFont.boldSystemFont(ofSize: 19)
        static let heading = UIFont.systemFont(ofSize: 23)
        static let headingBold = UIFont.boldSystemFont(ofSize: 23)
    }
}

struct ProductionServer {
    static let baseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
    case plain = "text/plain"
}
