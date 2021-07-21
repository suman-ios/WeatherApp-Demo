//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Dev on 2021-07-19.
//

import Foundation
class WeatherModel: Codable {
    var location: LocationModel?
    var current: CurrentModel?
    var forecast: ForecastModel?
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case current = "current"
        case forecast = "forecast"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        location = try container.decode(LocationModel.self, forKey: .location)
        current = try container.decode(CurrentModel.self, forKey: .current)
        forecast = try container.decode(ForecastModel.self, forKey: .forecast)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(location, forKey: .location)
        try container.encode(current, forKey: .current)
        try container.encode(forecast, forKey: .forecast)
    }
}

class LocationModel: Codable {
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

class CurrentModel: Codable {
    var temperatureC: Float?
    var humidity: Float?
    var wind: Float?
    var feelsLike: Float?
    var precipIn: Float?
    var pressure: Float?
    var uv: Float?
    var visibility: Float?
    var condition: ConditionModel?
    
    enum CodingKeys: String, CodingKey {
        case temperatureC = "temp_c"
        case humidity = "humidity"
        case wind = "wind_mph"
        case feelsLike = "feelslike_c"
        case precipIn = "precip_in"
        case pressure = "pressure_in"
        case uv = "uv"
        case visibility = "vis_miles"
        case condition = "condition"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperatureC = try container.decode(Float.self, forKey: .temperatureC)
        humidity = try container.decode(Float.self, forKey: .humidity)
        wind = try container.decode(Float.self, forKey: .wind)
        feelsLike = try container.decode(Float.self, forKey: .feelsLike)
        precipIn = try container.decode(Float.self, forKey: .precipIn)
        pressure = try container.decode(Float.self, forKey: .pressure)
        uv = try container.decode(Float.self, forKey: .uv)
        visibility = try container.decode(Float.self, forKey: .visibility)
        condition = try container.decode(ConditionModel.self, forKey: .condition)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(temperatureC, forKey: .temperatureC)
        try container.encode(humidity, forKey: .humidity)
        try container.encode(wind, forKey: .wind)
        try container.encode(feelsLike, forKey: .feelsLike)
        try container.encode(precipIn, forKey: .precipIn)
        try container.encode(pressure, forKey: .pressure)
        try container.encode(uv, forKey: .uv)
        try container.encode(visibility, forKey: .visibility)
        try container.encode(condition, forKey: .condition)
    }
}

class ConditionModel: Codable {
    var text: String?
    var icon: String?
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case icon = "icon"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)
        icon = try container.decode(String.self, forKey: .icon)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try container.encode(icon, forKey: .icon)
    }
}

class ForecastModel: Codable {
    var forecastday: [ForecastDayModel]?
    
    enum CodingKeys: String, CodingKey {
        case forecastday = "forecastday"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        forecastday = try container.decode([ForecastDayModel].self, forKey: .forecastday)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(forecastday, forKey: .forecastday)
    }
}

class ForecastDayModel: Codable {
    var date: String?
    var day: DayModel?
    var astro: AstroModel?
    var hour: [HourModel]?
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case day = "day"
        case hour = "hour"
        case astro = "astro"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(String.self, forKey: .date)
        day = try container.decode(DayModel.self, forKey: .day)
        hour = try container.decode([HourModel].self, forKey: .hour)
        astro = try container.decode(AstroModel.self, forKey: .astro)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(day, forKey: .day)
        try container.encode(hour, forKey: .hour)
        try container.encode(astro, forKey: .astro)
    }
}

class AstroModel: Codable {
    var sunset: String?
    var sunrise: String?
    
    enum CodingKeys: String, CodingKey {
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sunrise = try container.decode(String.self, forKey: .sunrise)
        sunset = try container.decode(String.self, forKey: .sunset)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sunrise, forKey: .sunrise)
        try container.encode(sunset, forKey: .sunset)
    }
}

class DayModel: Codable {
    var maxTemp: Float?
    var minTemp: Float?
    var chanceOfRain: String?
    var condition: ConditionModel?
    
    enum CodingKeys: String, CodingKey {
        case maxTemp = "maxtemp_c"
        case minTemp = "mintemp_c"
        case chanceOfRain = "daily_chance_of_rain"
        case condition = "condition"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        maxTemp = try container.decode(Float.self, forKey: .maxTemp)
        minTemp = try container.decode(Float.self, forKey: .minTemp)
        chanceOfRain = try container.decode(String.self, forKey: .chanceOfRain)
        condition = try container.decode(ConditionModel.self, forKey: .condition)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(maxTemp, forKey: .maxTemp)
        try container.encode(minTemp, forKey: .minTemp)
        try container.encode(chanceOfRain, forKey: .chanceOfRain)
        try container.encode(condition, forKey: .condition)
    }
}

class HourModel: Codable {
    var temp: Float?
    var time: String?
    var condition: ConditionModel?
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp_c"
        case time = "time"
        case condition = "condition"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temp = try container.decode(Float.self, forKey: .temp)
        time = try container.decode(String.self, forKey: .time)
        condition = try container.decode(ConditionModel.self, forKey: .condition)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(temp, forKey: .temp)
        try container.encode(time, forKey: .time)
        try container.encode(condition, forKey: .condition)
    }
}
