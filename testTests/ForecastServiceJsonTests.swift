//
//  ForecastServiceJsonTests.swift
//

import XCTest
@testable import test

final class ForecastServiceJsonTests: XCTestCase {

    func test_getForecastFromLocalJson_shouldReturn40Items() throws {
        
        // GIVEN
        let sut: ForecastService = ForecastServiceJson()
        let exp = expectation(description: "Request complete")
        let expectedItemsCount = 40
        
        // WHEN
        sut.getForecasts(city: "") { result in
            
            // THEN
            switch result {
            case .success(let forecastResponse):
                XCTAssertEqual(forecastResponse.items?.count, expectedItemsCount)
            case .failure:
                XCTFail("Success expected")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
    }

}
