//
//  ForecastService.swift
//

import Foundation

protocol ForecastService {
    
    func getForecasts(city: String,
                      completion: RequestCompletion<ForecastRequest.ResponseType>?
    )
}
