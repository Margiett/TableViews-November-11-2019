//
//  ViewController.swift
//  TableViews November 11 2019
//
//  Created by Margiett Gil on 11/11/19.
//  Copyright © 2019 Margiett Gil. All rights reserved.
//

import UIKit

//MARK: Web: UITableView

//https://developer.apple.com/documentation/uikit/uitableview

//MARK: Web: UITableViewDataSource
//https://developer.apple.com/documentation/uikit/uitableviewdatasource
// numberOfRowsInSection

//MARK: Web: UITableViewCell
//https://developer.apple.com/documentation/uikit/uitableviewcell


class ViewController: UIViewController {
// MARK: Topic covered
    // - UITableView
    // - ce;;s can be static or dynamic
    // - prototypeCell
    // - reuse identified e.g "countryCell"
    // - dataSource object (WE NEED TO SET THE DATASOURCE OBJECT e.g tableView.dataSource = self, configure in viewDidLoad()
    // - UITableViewDataSource - 2 required methods
    // - first required methods is numberOfRows()
    // - second required methods is cellForRow()
    // - cellForRow
    // - dequeueCell - recycles a cell if in memory, if not it creates a new cell
    
//MARK: - outlets and properties
    
    @IBOutlet weak var tableView: UITableView!
    // data for the view controller
    private var countries = [Country]() { // this is empty array
        //property observer
        didSet {
            // didSet gets called when the countries get modified ,
            // reload the table view
            // every cell gets reloaded
            // reloads all the rows of the table view
            tableView.reloadData()
        }
    }
    
    
    // MARK: - viewcontroller life cycle methods
    private var sortAscending = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortData(true)
        
//configuring a table view
// MARK: Step 1: sey the data source object
// set the data source object
//meaning the object that will provide the table view its data (cell data)
        tableView.dataSource = self
        // is the viewController instance example self.
            
            
        // testing data
        
        // if we wanted it alphabepical we would write the code here
        // sort 
        print("There are \(Country.countries.count) countries in our struct")
        
    }
    
    @IBAction func sortButtonPress(_ sender: UIBarButtonItem) {
        sortAscending.toggle()
        sortData(sortAscending)
        
    }
    func sortData(_ sortAscending: Bool) {
        if sortAscending {
            countries = Country.countries.sorted{$0.name < $1.name} // <ascending
            // our table view reloads because we are using a property observer didSet {}
            //willSet {....}
            // update the UIBarButtonItem's title we dragged in to interface builder
            navigationItem.rightBarButtonItem?.title = "Sort Ascending"
        }else {
        countries = Country.countries.sorted{$0.name < $1.name}
    }
}
// static you can not mutate nor can you mutate let



}


//MARK: Step 2 conform to UITableViewDataSource
extension ViewController: UITableViewDataSource {
    // 2 Required METHODS
    
    
//MARK: Method 1: mumberOfRows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
// MARK: Method 2:
//MARK: Web: IndexPath
// https://developer.apple.com/documentation/foundation/indexpath
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //MARK: dequeueReusableCell(withIdentifier:)
//https://developer.apple.com/documentation/uikit/uitableview/1614891-dequeuereusablecell
        //dequeueReusableCell:
        //recycles a cell if it it exist
        // if the cell does not exist a new cell is created
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) // this will recycle the cell it wont create a new cell the only thing that changes is the label name but keeps the contain
        
    // get the object at the current indexPath
        // this is how we access a flat array
        let country = countries[indexPath.row]
        
        // configuring the cell
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.description
        return cell
        
        
        
        
       // let arrOfArrays = [[1,2,3], [4,5,6,], [7,8,9]]
        // arrOfArrays [IndexPath.section][indexPath.row]
        // arrOfArrays[0][0] // print out 1
        
//let flatArr = [1,2,3]
      //  flatArr[indexPath.row]
        // this will access your current section
        //if you dont have a array of array = matrix  you will use indexPath.row
    }
    
}
