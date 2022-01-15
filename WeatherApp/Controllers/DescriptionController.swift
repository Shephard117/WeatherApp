//
//  DescriptionController.swift
//  WeatherApp
//
//  Created by Дмитрий Скоробогаты on 28.12.2021.
//

import UIKit

class DescriptionController: UIViewController {
    
    
    var tempLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-25"
        return label
    }()
    
    var cityLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Город"
        return label
    }()
    
    var windLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Сильный ветер"
        return label
        
    }()
    
    var weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "cloud.snow")
        return imageView
    }()
    
    let backgroundImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var pressureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var feelsLike: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    func setName(name: String){
        cityLabel.text = name
        print(name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        setUI()
    }
    
}


extension DescriptionController {
    
    func setUI(){
    
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        ])
        
        view.addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(weatherImage)
        NSLayoutConstraint.activate([
            weatherImage.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            weatherImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 170),
            weatherImage.widthAnchor.constraint(equalToConstant: 60),
            weatherImage.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 20),
            tempLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 170),
            tempLabel.widthAnchor.constraint(equalToConstant: 50),
            tempLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(windLabel)
        NSLayoutConstraint.activate([
            windLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            windLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 40)
        ])
        
        view.addSubview(pressureLabel)
        NSLayoutConstraint.activate([
            pressureLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 10),
            pressureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90)
        ])
        
        view.addSubview(feelsLike)
        NSLayoutConstraint.activate([
            feelsLike.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: 10),
            feelsLike.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90)
        ])
        
    }
    
}


extension DescriptionController: WeatherControllerDelegate {
    
    func updateWeather(with weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherImage.image = UIImage(systemName: weather.conditionImageText)
            self.tempLabel.text =  weather.temperatureString + "С°"
            self.pressureLabel.text = "Атмосферное давление: \(weather.pressure) мм. рт. ст."
            self.feelsLike.text = "Ощущается как: \(weather.feelsLike) С°"
            self.windLabel.text = "Скорость ветра: \(weather.windSpeed) м/с"
            self.cityLabel.text = weather.name

        }
        print(weather.temperatureString)
    }
}
