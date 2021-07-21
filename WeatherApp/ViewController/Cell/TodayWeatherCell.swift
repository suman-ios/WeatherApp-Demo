//
//  TodayWeatherCell.swift
//  WeatherApp
//
//  Created by Dev on 2021-07-19.
//

import UIKit

class TodayWeatherCell: UITableViewCell {
    @IBOutlet weak var lblTitlePressure: UILabel!
    @IBOutlet weak var lblTitlePrecipitation: UILabel!
    @IBOutlet weak var lblTitleChanceOfrain: UILabel!
    @IBOutlet weak var lblTitleWind: UILabel!
    @IBOutlet weak var lblTitleSunrise: UILabel!
    @IBOutlet weak var lblTitleFeelLike: UILabel!
    @IBOutlet weak var lblTitleHumidity: UILabel!
    @IBOutlet weak var lblTitleSunset: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var chanceOfRainLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var percipitionLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var uxIndexLabel: UILabel!
    @IBOutlet weak var lblWeatherDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCurrentWeather(current: CurrentModel?, day: DayModel?, astro: AstroModel?, forecast: ForecastModel?) {
        
        lblTitleSunrise.text = Title.sunrise.localized
        lblTitleSunset.text = Title.sunset.localized
        lblTitleHumidity.text = Title.humidity.localized
        lblTitleChanceOfrain.text = Title.chanceOfRain.localized
        lblTitleFeelLike.text = Title.feelsLike.localized
        lblTitlePrecipitation.text = Title.precipitation.localized
        lblTitlePressure.text = Title.pressure.localized
        lblTitleWind.text = Title.wind.localized
        
        humidityLabel.text = "\(current?.humidity ?? 0)%"
        windLabel.text = "wsw \(current?.wind ?? 0) mph"
        feelsLikeLabel.text = "\(current?.feelsLike ?? 0)°"
        percipitionLabel.text = "\(current?.precipIn ?? 0) in"
        pressureLabel.text = "\(current?.pressure ?? 0) in"
        visibilityLabel.text = "\(current?.visibility ?? 0) mi"
        uxIndexLabel.text = "\(current?.uv ?? 0)"
        
        chanceOfRainLabel.text = "\(day?.chanceOfRain ?? "")%"
        sunriseLabel.text = astro?.sunrise ?? ""
        sunsetLabel.text = astro?.sunset ?? ""
        
        lblWeatherDescription.text = "TODAY: Currently \(current?.condition?.text ?? ""). The high will be \(forecast?.forecastday?.first?.day?.maxTemp ?? 0) and the low will be \(forecast?.forecastday?.first?.day?.minTemp ?? 0)"
    }

}
