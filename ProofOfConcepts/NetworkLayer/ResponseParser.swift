//
//  ResponseParser.swift
//  ProofOfConcepts
//
//  Created by Avinash Patel on 4/19/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import Foundation

class ResponseParser {
    // Function to parse response from String to PhotoList
    static func parse(from: String) -> PhotoList? {
        do {
            guard let jsonData = from.data(using: String.Encoding.utf8) else { return nil }
            
            guard let resultDic = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: AnyObject] else { return nil }
            return try DictionaryDecoder().decode(PhotoList.self, from: resultDic)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
