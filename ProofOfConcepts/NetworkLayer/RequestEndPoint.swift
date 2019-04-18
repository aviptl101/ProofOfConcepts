//
//  RequestEndPoint.swift
//  ProofOfConcepts
//
//  Created by Avinash Patel on 4/19/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import Foundation
import Alamofire

enum RequestEndPoint: URLRequestConvertible  {
    
    case photos(page: Int)
    case searchPhoto(forTerm: String, page: Int)
    case login(email:String, password:String)
    
    // MARK: HTTPMethod
    
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .searchPhoto, .photos:
            return .get
        }
    }
    
    // MARK: Path
    
    private var path: String {
        switch self {
        case .login:
            return "/login"
        case .searchPhoto(let id):
            return "/article/\(id)"
        case .photos:
            return "/facts.json"
        }
    }
    
    // MARK: Parameters
    
    private var parameters: Parameters? {
        switch self {
        case .photos, .searchPhoto:
            return nil
        case .login(let email, let password):
            return ["email": email, "password": password]
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        switch self {
        case .photos:
            urlRequest.setValue(ContentType.plain.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            urlRequest.setValue(ContentType.plain.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        default:
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        }
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
