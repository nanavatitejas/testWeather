//
//  APIManagerTests.swift
//

import XCTest
@testable import test

// swiftlint:disable all
final class RequestManagerTests: XCTestCase {

    func test_requestManager_shouldCallCompluetionWithResult() {
        
        // GIVEN
        let sut = RequestManagerDefault()
        let exp = expectation(description: "request complete")
        let request = ForecastRequest(city: "Munich")
        
        // WHEN
        sut.fetch(request) { result in
            
            // THEN
            switch result {
            case .success(let response):
                XCTAssertEqual(response.city?.name, "Munich")
            case .failure(let error):
                XCTFail("Should not fail: \(error)")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
    }
    
    func test_requestManager_shouldCallCompletionWithError() {
        
        // GIVEN
        let sessionMock: URLSessionProtocol = URLSessionMock(data: nil, response: nil, error: ApiError.noData)
        let sut = RequestManagerDefault(urlSession: sessionMock)
        let exp = expectation(description: "request complete")
        let request = ForecastRequest(city: "Munich")
        
        // WHEN
        sut.fetch(request) { result in
            
            // THEN
            switch result {
            case .success:
                XCTFail("Response with empty data should not succeed")
            case .failure(let error):
                XCTAssertEqual(error, ApiError.noData)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2)
    }

}
// swiftlint:enable all
