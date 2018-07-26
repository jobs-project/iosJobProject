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
    var type: String
    var salary: Int
    
    init (title: String, location: String, date: String, description: String, type: String, salary: Int) {
        self.title = title
        self.location = location
        self.date = date
        self.description = description
        self.type = type
        self.salary = salary
    }
}
