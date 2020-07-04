//
//  CityViewModel.swift
//  test
//
//  Created by Tejas Nanavati on 03/07/20.
//  Copyright © 2020 Tejas Nanavati. All rights reserved.
//

import Foundation




struct CityViewModel{
    
    var cityList = [WelcomeElement]()
    
    var filtercityList = [WelcomeElement]()

    
    mutating func loadJson(filename fileName: String)->[WelcomeElement?]  {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let welcome = try JSONDecoder().decode([WelcomeElement].self, from: data)
                self.cityList = welcome
                return self.cityList

            } catch {
                print("error:\(error)")
            }
        }
        return []
    }
    
    
}
