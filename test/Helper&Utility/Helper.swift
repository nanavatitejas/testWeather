//
//  Helper.swift
//  test
//
//  Created by Tejas Nanavati on 03/07/20.
//  Copyright © 2020 Tejas Nanavati. All rights reserved.
//
import Foundation

class Helper {
    class func getDegreeCelsius(temprature:Double,convertToCelsius:Bool)->String{
        var kelvinToCelsius = 0.0
        if convertToCelsius{
             kelvinToCelsius = round(300 - temprature)

        } else{
            kelvinToCelsius = round(temprature)
        }

        let measurement = Measurement(value: kelvinToCelsius, unit: UnitTemperature.celsius)

        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit

        return measurementFormatter.string(from: measurement) + "C"
    }
}
