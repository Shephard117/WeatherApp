//
//  ListCell.swift
//  WeatherApp
//
//  Created by Дмитрий Скоробогаты on 27.12.2021.
//

import UIKit

class ListCell: UITableViewCell {

    let cityLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cityLable)
        NSLayoutConstraint.activate([
            cityLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cityLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1)
        ])
        
        contentView.addSubview(conditionLabel)
        NSLayoutConstraint.activate([
            conditionLabel.leadingAnchor.constraint(equalTo: cityLable.trailingAnchor, constant: 10),
            conditionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1)
        ])
        
        contentView.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
