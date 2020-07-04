//
//  NetworkManage.swift
//  test
//
//  Created by Tejas Nanavati on 03/07/20.
//  Copyright © 2020 Tejas Nanavati. All rights reserved.
//

import Foundation
final class NetworkManager {
    static  let shared = NetworkManager()
    private init() {}
    
    
    private let apiKey = "e8c96b522cbcc77345dc1229daa70bc9"
    let urlFor5 = "https://api.openweathermap.org/data/2.5/forecast?"
    let urlCurrent = "https://api.openweathermap.org/data/2.5/weather?"
   
    
    
    func getCurrentWeather(city:String, code:String,completion: @escaping (([String:Any]?) -> Void)) {
        
        
        let q = city + "," + code
        
        let urlstr  = "http://api.openweathermap.org/data/2.5/weather?q=\(q)&appid=75fdcaa60084b1a7b2a5fb02ef4bb7c9"
               
               guard let url = URL(string: urlstr) else {
                   return
               }
               
               
               let request = URLRequest(url: url)
               
               
               URLSession.shared.dataTask(with: request) { data, response, error in
                   if error == nil {
                       do {
                           let res = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any]
                           completion(res)
                       } catch let error {
                           completion(nil)
                           print(error.localizedDescription)
                       }
                       
                   } else {
                    print(error?.localizedDescription as Any)
                   }
               }.resume()
        
        
        
        
        
    }
    
    func getWeatherFor5Days(city:String,completion: @escaping (([String:Any]?) -> Void)) {
        
        let urlstr  = "http://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=75fdcaa60084b1a7b2a5fb02ef4bb7c9"
        
        guard let url = URL(string: urlstr) else {
            return
        }
        
        
        let request = URLRequest(url: url)
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil {
                do {
                    let res = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any]
                    completion(res)
                } catch let error {
                    completion(nil)
                    print(error.localizedDescription)
                }
                
            } else {
                print(error?.localizedDescription as Any)
            }
        }.resume()
    }
    
}
