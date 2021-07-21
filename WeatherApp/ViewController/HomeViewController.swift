//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Dev on 2021-07-19.
//

import UIKit
import CoreLocation
import NVActivityIndicatorView

class HomeViewController: UIViewController {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var conditionLabelLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var minMaxTemperatureLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: NVActivityIndicatorView!
    
    lazy var locationManager = LocationService.sharedInstance
    lazy var presenter = HomePresenter(viewDelegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.locationDelegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if self.locationManager.isLocationServiceEnabled() {
                self.locationManager.startUpdatingLocation()
            } else {
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.requestLowAccuracy()
            }
        }
        indicatorView.color = UIColor.white
        indicatorView.type = .ballScaleMultiple
        indicatorView.startAnimating()
        tableView.tableFooterView = UIView()
    }
    
    func showAlert(withMessage: String) {
        let alert = UIAlertController(title: "", message: withMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension HomeViewController: LocationAutorizationDelegate {
    func errorWith(message: String) {
        indicatorView.stopAnimating()
        print("Error: ", message)
        presenter.getWeatherDataOffline()
    }
    
    func updateLocationName() {
        if !NetworkConnectionManager.shared.connected {
            //Fetch offline
            presenter.getWeatherDataOffline()
        } else if !locationManager.getCurrentLocationName().isEmpty {
            presenter.getWeatherData(cityName: locationManager.getCurrentLocationName())
        }
    }
    
    func tracingAuthorization() {
        if !locationManager.isLocationServiceEnabled() {
            self.showAlert(withMessage: Message.enableLocation.localized)
        }
    }
}

extension HomeViewController: HomeViewProtocol {
    func finishGettingWeatherDetailsWithSuccess() {
        indicatorView.stopAnimating()
        guard let weatherData = presenter.weatherData else {
            return
        }
        view.transform = CGAffineTransform(scaleX: 0.00001, y: 0.00001)
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.view.transform = CGAffineTransform.identity
        })
        self.cityNameLabel.text = weatherData.location?.name ?? ""
        self.currentTemperatureLabel.text = "\(weatherData.current?.temperatureC ?? 0)°"
        self.conditionLabelLabel.text = weatherData.current?.condition?.text ?? ""
        self.minMaxTemperatureLabel.text = "H:\(weatherData.forecast?.forecastday?.first?.day?.maxTemp ?? 0)°   L:\(weatherData.forecast?.forecastday?.first?.day?.minTemp ?? 0)°"
        self.collectionView.reloadData()
        self.tableView.reloadData()
        collectionView.scrollToItem(at: presenter.currentTimeIndex(), at: .centeredHorizontally, animated: true)
    }
    
    func finishGettingWeatherDetailsWithError(errorMessage: String) {
        indicatorView.stopAnimating()
        presenter.getWeatherDataOffline()
        self.showAlert(withMessage: errorMessage)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.row(for: indexPath) {
        case .nextDayWeather(let weatherData):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NextDayWeatherCell", for: indexPath) as? NextDayWeatherCell {
                cell.configureForcastDay(forcastDay: weatherData)
                return cell
            }
        case .todayWeather(let currentData, let dayData, let astroData, let foreCast):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TodayWeatherCell", for: indexPath) as? TodayWeatherCell {
                cell.configureCurrentWeather(current: currentData, day: dayData, astro: astroData, forecast: foreCast)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch presenter.row(for: indexPath) {
        case .nextDayWeather:
            return 40
        case .todayWeather:
            return 350
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getTodaysForcast()?.hour?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyTemperatureCell", for: indexPath) as? HourlyTemperatureCell {
            cell.configureData(hour: presenter.getTodaysForcast()?.hour?[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 130)
    }
}

