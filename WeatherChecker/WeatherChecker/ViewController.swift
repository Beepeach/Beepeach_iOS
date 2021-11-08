//
//  ViewController.swift
//  WeatherChecker
//
//  Created by JunHeeJo on 11/8/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: @IBOutlet
    @IBOutlet weak var cityNameField: UITextField!
    @IBOutlet weak var weatherStackView: UIStackView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: @IBAction
    @IBAction func tapFetchWeather(_ sender: Any) {
        if let cityName = self.cityNameField.text {
            self.getCurrentWeather(to: cityName)
            self.view.endEditing(true)
        }
    }
    
    func getCurrentWeather(to cityName: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(weatherAPIKey)") else {
            return
        }
        
        let session: URLSession = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] data, response, error in
            let successRange = (200..<300)
    
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {
                return
            }
            
            let decoder: JSONDecoder = JSONDecoder()
            
            if let response = response as? HTTPURLResponse,
               successRange.contains(response.statusCode) {
                guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else {
                    return
                }
                
                
                DispatchQueue.main.async {
                    self?.weatherStackView.isHidden = false
                    self?.configureView(with: weatherInformation)
                }
            } else {
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else {
                    return
                }
                
                debugPrint(errorMessage)
                
                DispatchQueue.main.async {
                    self?.showAlert(with: errorMessage)
                }
            }
         
        }.resume()
    }
    
    private func configureView(with weatherInformation: WeatherInformation) {
        self.cityNameLabel.text = weatherInformation.name
        if let weather = weatherInformation.weather.first {
            self.weatherDescriptionLabel.text = weather.description
        }
        self.tempLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))"
        self.minTempLabel.text = "최저 : \(Int(weatherInformation.temp.minTemp - 273.15))"
        self.maxTempLabel.text = "최고 : \(Int(weatherInformation.temp.maxTemp - 273.15))"
    }
    
    private func showAlert(with message: ErrorMessage) {
        let alert = UIAlertController(title: "title", message: message.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

