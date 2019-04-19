//
//  ProofOfConceptsTests.swift
//  ProofOfConceptsTests
//
//  Created by Avinash Patel on 4/18/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import XCTest
@testable import ProofOfConcepts

class ProofOfConceptsTests: XCTestCase {

    var photoCollectionViewController: PhotoCollectionViewController!
    var photosViewModel: PhotosViewModel!
    
    override func setUp() {
        //get the ViewController we want to test from the storyboard (note the identifier is the id explicitly set in the identity inspector)
        photoCollectionViewController = PhotoCollectionViewController()
        photosViewModel = PhotosViewModel()
        
        //load view hierarchy
        _ = photoCollectionViewController.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPhotosViewModel() {
        photosViewModel.downloadPhotos(completion: { (result) in
            switch result {
            case true: XCTAssertNotNil(self.photosViewModel.photos)
            case false: XCTFail()
            }
        })
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            photosViewModel.downloadPhotos(completion: { (result) in
                switch result {
                case true: XCTAssertNotNil(self.photosViewModel.photos)
                case false: XCTFail()
                }
            })
        }
    }

}
