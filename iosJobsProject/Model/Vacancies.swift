//
//  Vacancies.swift
//  iosJobsProject
//
//  Created by Eugene Posikyra on 24.07.2018.
//  Copyright © 2018 Eugene Posikyra. All rights reserved.
//

import Foundation
import UIKit

class Vacancies {
    var title: String
    var location: String
    var date: String
    var description: String
    var company: String
    var salary: Int
    var cellurl: String
    var currency: String
    
    init (title: String, location: String, date: String, description: String, company: String, salary: Int, cellurl: String, currency: String) {
        self.title = title
        self.location = location
        self.date = date
        self.description = description
        self.company = company
        self.salary = salary
        self.cellurl = cellurl
        self.currency = currency
    }
}
