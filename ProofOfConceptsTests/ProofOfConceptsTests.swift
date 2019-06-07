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
        let photosExpectation = expectation(description: "photos")
        
        photosViewModel.downloadPhotos(completion: { (result) in
            switch result {
            case true: photosExpectation.fulfill()
            case false: XCTFail()
            }
        })
        
        waitForExpectations(timeout: 2) { (error) in
            XCTAssertNotNil(self.photosViewModel.photos)
        }
    }
    
    func testCollectionViewImagesNames() {
        let photosExpectation = expectation(description: "photos")
        let imagesNames = ["Beavers", "Flag", "Transportation", "Hockey Night in Canada", "Eh", "Housing", "Public Shame", "", "Space Program", "Meese", "Geography", "Kittens...", "Mounties", "Language"]

        photosViewModel.downloadPhotos(completion: { (result) in
            switch result {
            case true: guard let photos = self.photosViewModel.photos else { return }
            for index in 0...imagesNames.count - 1 {
                let imageName = photos[index].title ?? ""
                XCTAssertEqual(imagesNames[index], imageName, "Image should be matching")
            }
            photosExpectation.fulfill()
            case false: XCTFail()
            }
        })
        
        waitForExpectations(timeout: 2) { (error) in
            XCTAssertNotNil(self.photosViewModel.photos)
        }
    }
    
    func testCanInstantiateViewController() {
        XCTAssertNotNil(photoCollectionViewController)
    }
    
    func testCollectionViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(photoCollectionViewController.collectionView)
    }
    
    func testShouldSetCollectionViewDataSource() {
        XCTAssertNotNil(photoCollectionViewController.collectionView.dataSource)
    }
    
    func testConformsToCollectionViewDataSource() {
        XCTAssertTrue(photoCollectionViewController.responds(to: #selector(photoCollectionViewController.collectionView(_:numberOfItemsInSection:))))
        
        XCTAssertTrue(photoCollectionViewController.responds(to: #selector(photoCollectionViewController.collectionView(_:cellForItemAt:))))
    }
    
    func testShouldSetCollectionViewDelegate() {
        XCTAssertNotNil(photoCollectionViewController.collectionView.delegate)
    }
    
    func testConformsToCollectionViewDelegate() {
        XCTAssert(photoCollectionViewController.conforms(to: UICollectionViewDelegate.self))
    }
}
