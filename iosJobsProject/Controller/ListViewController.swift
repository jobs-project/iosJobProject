//
//  ListViewController.swift
//  iosJobsProject
//
//  Created by Eugene Posikyra on 25.07.2018.
//  Copyright © 2018 Eugene Posikyra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ListViewController: UITableViewController, UISearchResultsUpdating {
    
    var vacanciesArray: [Vacancies] = []
    var filteredVacancies: [Vacancies] = []
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        //filteredVacancies = vacanciesArray.filter({( testvacancy : Vacancies) -> Bool in
           // return testvacancy.title.lowercased().contains(searchText.lowercased())})
        vacanciesArray.removeAll()
        let searchRequest: String = "http://159.65.200.195/job/search?title=\(searchText)"
        getData(url: searchRequest)
        
        tableView.reloadData()
    }
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    
   
    let searchRequest: String = "http://159.65.200.195/job/search?title=nurse&salary=10000&location=London&description=blablabla"
    
    let infoURL = "http://159.65.200.195/job?page=1"
    let infoURL2 = "http://159.65.200.195/job?page=2"
    
    override func viewDidLoad() {
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        
        
        super.viewDidLoad()
        getData(url: infoURL)
        tableView.delegate = self
        tableView.dataSource = self
        setupNavBar()
        navigationItem.largeTitleDisplayMode = .automatic
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search vacancies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
        
        
        
    
        
        navigationItem.hidesSearchBarWhenScrolling = false
        //let params: [String: String] = ["search": self.searchRequest]
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredVacancies.count
        }
        return vacanciesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vacancyCell") as! CellForList
        let vacancy = vacanciesArray[indexPath.row]
        let filteredVacancy: Vacancies
        
        if isFiltering() {
            filteredVacancy = filteredVacancies[indexPath.row]
        } else {
            filteredVacancy = vacanciesArray[indexPath.row]
            
        }
        
        print(vacancy.title)
        cell.setVacancy(vacancy: filteredVacancy)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToVacancy", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToVacancy" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! WebViewController
                let vacancy = vacanciesArray[indexPath.row]
                
                dvc.url = URL(string: vacancy.cellurl)
            }
        }
    }
    
    
    
    //MARK: - Networking
    func getData(url: String) {
        Alamofire.request(url, method: .get).responseJSON { response in
            
            if response.result.isSuccess {
                print("Success, got the data!")
                let vacanciesJSON: JSON = JSON(response.result.value!)
                print(vacanciesJSON)
                //var numberOfVacancies = vacanciesJSON.count
                
                for i in 0..<(vacanciesJSON.count) {
                    
                    self.vacanciesArray.append(self.updateData(json: vacanciesJSON, numberInJSONArray: i))
                    
                }
                
                self.tableView.reloadData()
                //let data = self.updateData(json: vacanciesJSON)
            } else {
                print("Error \(response.result.error)")
            }
        }
        
    }
    
    //MARK: - JSON Parsing
    
    func updateData(json: JSON, numberInJSONArray: Int) -> Vacancies {
        
        let titleResult = json[numberInJSONArray]["title"].string
        let locationResult = json[numberInJSONArray]["location"].string
        let dateResult = json[numberInJSONArray]["date"].string
        let descriptionResult = json[numberInJSONArray]["description"].string
        let companyResult = json[numberInJSONArray]["company"].string
        let salaryResult = json[numberInJSONArray]["salary"].int
        let cellUrlResult = json[numberInJSONArray]["url"].string
        let currencyResult = json[numberInJSONArray]["currency"].string
        let testvacancy = Vacancies(title: titleResult!, location: locationResult!, date: dateResult!, description: descriptionResult!, company: companyResult!, salary: salaryResult!, cellurl: cellUrlResult!, currency: currencyResult!)
        
        return testvacancy
    }
    
   
    
    
    
    
    
    
    
    

   
}
