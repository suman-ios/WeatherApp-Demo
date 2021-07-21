//
//  Extensions.swift
//  WeatherApp
//
//  Created by Dev on 2021-07-19.
//

import UIKit

extension String {
    func stringFromDate(inputDateFormate: String, outputDateFormate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputDateFormate
        let date = dateFormatter.date(from: self)
        return date?.stringFromDate(dateFormate: outputDateFormate) ?? "-"
    }
}

extension Date {
    func stringFromDate(dateFormate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormate
        return dateFormatter.string(from: self)
    }
}

extension UIImageView {
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}

extension Notification.Name {
    static let networkStatusChange = Notification.Name("__networkStatusChangeNotification")
}
