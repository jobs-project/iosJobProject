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

class ListViewController: UITableViewController {
    
    let infoURL = "http://82.146.40.234/job/"

    func getData(url: String) {
        Alamofire.request(url, method: .get).responseJSON { response in
            
            if response.result.isSuccess {
                print("Success, got the data!")
                let vacanciesJSON: JSON = JSON(response.result.value!)
                print(vacanciesJSON)
            } else {
                print("Error \(response.result.error)")
                
            }
            
        }
    }
    
    var vacancies: [Vacancies] = []
    //var someArray = ["love", "hate"]
    //var images = ["balkan.jpg", "bochka.jpg"]
    override func viewDidLoad() {
        super.viewDidLoad()
        vacancies = createArray()
        tableView.delegate = self
        tableView.dataSource = self
        setupNavBar()
        navigationItem.largeTitleDisplayMode = .automatic
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
        getData(url: infoURL)
    }
    
    func createArray() -> [Vacancies] {
        var tempVacancies: [Vacancies] = []
        
        let vacancy1 = Vacancies(title: "ios engineer", location: "Kyiv", date: "10.10.10", description: "asdfasdfasdfasdfasdf", type: "fulltime", salary: 15000)
        let vacancy2 = Vacancies(title: "java developer", location: "Dnepro", date: "12.12.12", description: "asdfasdfasdfasdf", type: "fulltime" , salary: 22000)
        tempVacancies.append(vacancy1)
        tempVacancies.append(vacancy2)
        return tempVacancies
    }
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacancies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let vacancy = vacancies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "vacancyCell") as! CellForList
        cell.setVacancy(vacancy: vacancy)
        //cell.textLabel?.text = someArray[indexPath.row]
        //cell.imageView?.image = UIImage(named: images[indexPath.row])
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToVacancy", sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
