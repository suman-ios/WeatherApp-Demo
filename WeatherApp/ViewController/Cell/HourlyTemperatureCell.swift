//
//  HourlyTemperatureCell.swift
//  WeatherApp
//
//  Created by Dev on 2021-07-19.
//

import UIKit

class HourlyTemperatureCell: UICollectionViewCell {
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureData(hour: HourModel?) {
        temperatureLabel.text = "\(hour?.temp ?? 0)°"
        timeLabel.text = (hour?.time ?? "")?.stringFromDate(inputDateFormate: DateFormateType.yyMMddHm, outputDateFormate: DateFormateType.Hma)
        weatherImageView.downloaded(from: "https:\(hour?.condition?.icon ?? "")")
    }
}
