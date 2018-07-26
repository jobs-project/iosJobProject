//
//  CellForList.swift
//  iosJobsProject
//
//  Created by Eugene Posikyra on 25.07.2018.
//  Copyright © 2018 Eugene Posikyra. All rights reserved.
//

import UIKit

class CellForList: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    func setVacancy(vacancy: Vacancies) {
        titleLabel.text = vacancy.title
        locationLabel.text = vacancy.location
        dateLabel.text = vacancy.date
        descriptionLabel.text = vacancy.description
        typeLabel.text = vacancy.type
        salaryLabel.text = String(vacancy.salary)
    }
}
