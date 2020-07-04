//
//  URLSessionDataTaskMock.swift
//

import Foundation

final class URLSessionDataTaskMock: URLSessionDataTask {
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var taskResponse: (Data?, URLResponse?, Error?)?
    
    override init() {}
    
    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler?(self.taskResponse?.0,
                                    self.taskResponse?.1,
                                    self.taskResponse?.2)
        }
    }
}
