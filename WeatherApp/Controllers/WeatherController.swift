//
//  ViewController.swift
//  WeatherApp
//
//  Created by Дмитрий Скоробогаты on 22.12.2021.
//

import UIKit
import CoreLocation

class WeatherController: UIViewController {

    let weatherTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    let weatherManager = WeatherManager()
    
    
    let cities = ["Сочи","Нью-Йорк","Новокузнецк"]

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTable.dataSource = self
        weatherTable.delegate = self
        setUI()
    }

    func findCity(city: String, handler: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()){
        CLGeocoder().geocodeAddressString(city) { placemark, error in
            
        }
    }

}


//MARK: - TableView Delegate Methods

extension WeatherController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cities[indexPath.row]
        cell.contentConfiguration = content
        return cell
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
