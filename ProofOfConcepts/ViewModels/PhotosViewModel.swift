//
//  PhotosViewModel.swift
//  ProofOfConcepts
//
//  Created by Avinash Patel on 4/19/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import Foundation

class PhotosViewModel {
    
    var title: String?
    var photos: [Photo]?
    
    func downloadPhotos(completion: @escaping (Bool) -> ()) {
        RequestManager.fetchPhotos { (result) in
            switch result {
            case .success(let photoList):
                self.title = photoList.title
                self.photos = photoList.photos
                completion(true)
            case .failure(let error):
                completion(false)
                print(error.localizedDescription)
            }
        }
    }
}
