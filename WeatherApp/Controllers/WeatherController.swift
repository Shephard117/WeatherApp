//
//  ViewController.swift
//  WeatherApp
//
//  Created by Дмитрий Скоробогаты on 22.12.2021.
//

import UIKit

class WeatherController: UIViewController {
    

    let weatherTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    var delegate: WeatherControllerDelegate?
    
    let weatherManager = WeatherManager()
    let cities = ["Нью-Йорк", "Сочи", "Новокузнецк", "Москва", "Кемерово", "Калиниград", "Новосибирск", "Томск", "Омск", "Красноярск"]
    var weather = WeatherModel()
    var citiesWeather = [WeatherModel]()

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCities()
        weatherTable.dataSource = self
        weatherTable.delegate = self
        setUI()
        if citiesWeather.isEmpty {
            citiesWeather = Array(repeating: weather, count: cities.count)
        }
       
        
    }

    func addCities() {
        
        getCityWeather(cities: cities) { index, weather in
            self.citiesWeather[index] = weather
            self.citiesWeather[index].name = self.cities[index]
            DispatchQueue.main.async {
                self.weatherTable.reloadData()
            }
        }
    }
    
    
    
}


//MARK: - TableView Delegate Methods

extension WeatherController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        cell.confugure(weather: citiesWeather[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myVC = DescriptionController()
        delegate = myVC
        delegate?.updateWeather(with: citiesWeather[indexPath.row])
        present(myVC, animated: true)
       
    }
    
}


//MARK: - setting constraint

extension WeatherController {
    
    func setUI() {
        
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        ])
        
        
        view.addSubview(weatherTable)
        NSLayoutConstraint.activate([
            weatherTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            weatherTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            weatherTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            weatherTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            
        ])
        
    }
    
}


protocol WeatherControllerDelegate{
    func updateWeather(with weather: WeatherModel)
}
