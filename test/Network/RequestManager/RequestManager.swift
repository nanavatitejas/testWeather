//
//  RequestManager.swift
//

import Foundation

typealias RequestResult<Res> = Result<Res, ApiError>
typealias RequestCompletion<Res> = (RequestResult<Res>) -> Void

/// Conformers of this protocol responsible for making network requests
/// They know nothing about specific endpoints
protocol RequestManager {
    
    static var defaultDecoder: JSONDecoder { get }
    
    func fetch<Req: ApiRequest>(_ request: Req,
                                completion: RequestCompletion<Req.ResponseType>?)
}
