//
//  Constants.swift
//  WeatherApp
//
//  Created by Dev on 2021-07-19.
//

import Foundation
struct DateFormateType {
    static let yyMMddHm = "yyyy-MM-dd HH:mm"
    static let yyMMdd = "yyyy-MM-dd"
    static let day = "EEEE"
    static let Hma = "hh:mm a"
}

struct Weather {
    static let store = "storeWeather"
}

struct Message {
    static let noWeatherData = "No weather data available"
    static let enableLocation = "Enable your location service."
    static let noInterNet = "Some issue with Internet"
    static let notGetinglocation = "Something went wrong while geting your location"
    static let genericError = "Generic_Message"
}

struct Title {
    static let sunrise = "SUNRISE"
    static let sunset = "SUNSET"
    static let chanceOfRain = "CHANCE OF RAIN"
    static let humidity = "HUMIDITY"
    static let wind = "WIND"
    static let feelsLike = "FEELS LIKE"
    static let precipitation = "PRECIPITATION"
    static let pressure = "PRESSURE"
}
