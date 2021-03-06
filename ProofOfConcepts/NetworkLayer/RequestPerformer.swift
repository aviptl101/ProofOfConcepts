//
//  RequestPerformer.swift
//  ProofOfConcepts
//
//  Created by Avinash Patel on 4/19/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import Alamofire

class RequestPerformer {
    @discardableResult
    // Gets Response in JSON and Parses directly using codable
    static func genericRequest<T: Decodable>(endPoint: RequestEndPoint, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (AFResult<T>) -> Void) -> DataRequest {
        return AF.request(endPoint).responseDecodable (decoder: decoder) { (response: DataResponse<T>) in
            completion(response.result)
        }
    }
    
    @discardableResult
    // Gets Response in Serialized String
    static func requestString(endPoint: RequestEndPoint, completion: @escaping (AFResult<PhotoList>) -> Void) -> DataRequest {
        return AF.request(endPoint).responseString { (response: DataResponse<String>) in
            switch response.result {
            case .success(let value):
                print(value)
                if let photoList = ResponseParser.parse(from: value) {
                    completion(Result.success(photoList))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
