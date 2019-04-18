//
//  RequestManager.swift
//  ProofOfConcepts
//
//  Created by Avinash Patel on 4/19/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    static func fetchPhotos(completion: @escaping (Result<PhotoList>) -> Void) {
        RequestPerformer.requestString(endPoint: .photos(page: 1), completion: completion)
    }
}
