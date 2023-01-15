//
//  ImageLoaderTests.swift
//  GithubPRsTests
//
//  Created by Amandeep on 16/01/23.
//

import XCTest
@testable import GithubPRs

final class ImageLoaderTests: XCTestCase {
    
    var imageLoader: ImageLoader!
    let session = MockImageSession()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCacheWorking() throws {
        let expectation = XCTestExpectation(description: #function)
        expectation.expectedFulfillmentCount = 2
      
        imageLoader = ImageLoader(session: session)
        imageLoader.loadImage(URL(string: "apple.co.in")!) { [weak self] result in
            expectation.fulfill()
            self?.imageLoader.loadImage(URL(string: "apple.co.in")!) { result in
                expectation.fulfill()
                
            }
        }
       
        wait(for: [expectation], timeout: 1.0)
        XCTAssert(session.count == 1)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
