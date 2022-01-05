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
        searchBar.placeholder = "Введите название города"
        return searchBar
    }()
    
    var delegate: WeatherControllerDelegate?
    
    let weatherManager = WeatherManager()
    var cities = ["Нью-Йорк", "Сочи", "Новокузнецк", "Москва", "Кемерово", "Калиниград", "Новосибирск", "Томск", "Омск", "Красноярск"]
    var weather = WeatherModel()
    var citiesWeather = [WeatherModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCities()
        weatherTable.dataSource = self
        weatherTable.delegate = self
        searchBar.delegate = self
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
        let descriptionVC = DescriptionController()
        delegate = descriptionVC
        delegate?.updateWeather(with: citiesWeather[indexPath.row])
        present(descriptionVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { action, view, handler in
            
            self.citiesWeather.remove(at: indexPath.row)
            self.cities.remove(at: indexPath.row)
            tableView.reloadData()
            
        }
        
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}

//MARK: - Search Bar Delegate Methods

extension WeatherController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let city = searchBar.text {
            findCity(city: city) { coordinate, error in
                if let coordinates = coordinate {
                    self.cities.append(city)
                self.weatherManager.fetchWeather(latitude: coordinates.latitude, longitude: coordinates.longitude) { weather in
                    var weatherMod = weather
                    weatherMod.name = city
                    self.citiesWeather.append(weatherMod)
                    DispatchQueue.main.async {
                        self.weatherTable.reloadData()
                    }
                }
                } else if error != nil {
                    let alert = UIAlertController(title: "Ошибка", message: "Возможно ошибка в названии города", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Хорошо", style: .destructive))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
            searchBar.text = ""
        
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
