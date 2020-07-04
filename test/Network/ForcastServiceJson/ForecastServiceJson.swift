//
//  ForecastServiceJson.swift
//

import Foundation

final class ForecastServiceJson {
    
    // MARK: Private Properties
    private let filename: String
    
    // MARK: Life Cycle
    init(filename: String = .defaultFileName
    ) {
        self.filename = filename
    }
}

// MARK: ForecastService
extension ForecastServiceJson: ForecastService {

    func getForecasts(city: String,
                      completion: RequestCompletion<ForecastRequest.ResponseType>?
    ) {
        do {
            let response: ForecastResponse = try read(from: filename)
            completion?(.success(response))
        } catch {
            completion?(.failure(ApiError.fileRead(error)))
        }
    }
}

// MARK: Private Methods
private extension ForecastServiceJson {
    func read<T: Decodable>(from fileName: String) throws -> T {
        
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json")
            else { throw ApiError.invalidRequest }
        
        let data = try Data(contentsOf: fileUrl)
        let decoder = RequestManagerDefault.defaultDecoder
        let result = try decoder.decode(T.self, from: data)
            
        return result
    }
}

private extension String {
    static let defaultFileName = "Kazan"
}
