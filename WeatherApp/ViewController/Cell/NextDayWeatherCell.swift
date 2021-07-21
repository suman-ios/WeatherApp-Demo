//
//  NextDayWeatherCell.swift
//  WeatherApp
//
//  Created by Dev on 2021-07-19.
//

import UIKit

class NextDayWeatherCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureForcastDay(forcastDay: ForecastDayModel?) {
        dayLabel.text = (forcastDay?.date ?? "").stringFromDate(inputDateFormate: DateFormateType.yyMMdd, outputDateFormate: DateFormateType.day)
        minTempLabel.text = "\(forcastDay?.day?.minTemp ?? 0)"
        maxTempLabel.text = "\(forcastDay?.day?.maxTemp ?? 0)"
        weatherImageView.downloaded(from: "https:\(forcastDay?.day?.condition?.icon ?? "")")
    }

}
