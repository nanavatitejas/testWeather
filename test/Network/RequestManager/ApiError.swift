//
//  ApiError.swift
//

import Foundation

enum ApiError: Error {
    case invalidRequest
    case clientSide(Error)
    case notHTTPResponse
    case serverSide(Data?)
    case noData
    case responseDecoding(Error)
    case fileRead(Error)
}

extension ApiError: Equatable {
    // not ok for production, simplified for testing
    static func == (lhs: ApiError, rhs: ApiError) -> Bool {
        type(of: lhs) == type(of: rhs)
    }
}
