//
//  HomePresenter.swift
//  WeatherApp
//
//  Created by Dev on 2021-07-19.
//

import Foundation
protocol HomeViewProtocol: class {
    func finishGettingWeatherDetailsWithSuccess()
    func finishGettingWeatherDetailsWithError(errorMessage: String)
}

class HomePresenter {
    weak private var viewDelegate: HomeViewProtocol?
    var weatherData: WeatherModel?
    var rows: [HomePresenter.Row] = []
    
    init(viewDelegate: HomeViewProtocol) {
        self.viewDelegate = viewDelegate
    }
    
    func getWeatherData(cityName: String) {
        WeatherAppManager.shared.getWeatherData(cityName: cityName) { [weak self](success, result) in
            if success, let result = result as? WeatherModel {
                self?.weatherData = result
                self?.prepareWeatherData()
                self?.storeWeatherData()
            } else {
                self?.viewDelegate?.finishGettingWeatherDetailsWithError(errorMessage: (result as? String) ?? Message.genericError.localized)
            }
        }
    }
    
    func prepareWeatherData() {
        rows.removeAll()
        for item in getNextForcasts() {
            rows.append(.nextDayWeather(item))
        }
        
        if let currentData = weatherData?.current, let day = getTodaysForcast()?.day, let astro = getTodaysForcast()?.astro, let forecast = weatherData?.forecast {
            rows.append(.todayWeather(currentData, day, astro, forecast))
        }
        self.viewDelegate?.finishGettingWeatherDetailsWithSuccess()
    }
    
    func getTodaysForcast() -> ForecastDayModel? {
        let date = Date().stringFromDate(dateFormate: DateFormateType.yyMMddHm)
        let contains = weatherData?.forecast?.forecastday?.filter({$0.date == date})
        if contains?.count ?? 0 > 0 {
            return contains?.first
        }
        
        return weatherData?.forecast?.forecastday?.first
    }
    
    private func getNextForcasts() -> [ForecastDayModel] {
        var nextForcasts = weatherData?.forecast?.forecastday ?? []
        if nextForcasts.count > 0 {
            nextForcasts.removeFirst()
        }
        return nextForcasts
    }
    
    private func storeWeatherData() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(weatherData) {
            UserDefaults.standard.set(data, forKey: Weather.store)
        }
    }
    
    func getWeatherDataOffline() {
        guard let jsonData = UserDefaults.standard.value(forKey: Weather.store) as? Data, let weatherModel = try? JSONDecoder().decode(WeatherModel.self, from: jsonData) else {
            self.viewDelegate?.finishGettingWeatherDetailsWithError(errorMessage: Message.noWeatherData.localized)
            return 
        }
        self.weatherData = weatherModel
        self.prepareWeatherData()
        self.viewDelegate?.finishGettingWeatherDetailsWithSuccess()
    }
    
    func currentTimeIndex() -> IndexPath {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return IndexPath(item: hour, section: 0)
    }
}

extension HomePresenter {
    enum Row {
        case nextDayWeather(ForecastDayModel)
        case todayWeather(CurrentModel, DayModel, AstroModel, ForecastModel)
    }
    
    func row(for indexPath: IndexPath) -> Row {
        return rows[indexPath.row]
    }
}
