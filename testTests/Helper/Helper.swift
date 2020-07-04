//
//  Helper.swift
//

import Foundation
@testable import test

final class JsonReader {
    
    func read<T: Decodable>(from fileName: String) throws -> T {
        
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json"),
            case let data = try Data(contentsOf: fileUrl),
            case let decoder = RequestManagerDefault.defaultDecoder,
            case let result = try decoder.decode(T.self, from: data)
            else { fatalError("Could not read \(fileName).json from bundle") }
        return result
    }
}
