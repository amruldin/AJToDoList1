//
//  ViewController.swift
//  AJToDoList
//
//  Created by Amruldin Jamalli on 12/30/17.
//  Copyright © 2017 Amruldin Jamalli. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["Call Him", "Call Bob", "BootCamp Meeting"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
    tableView.separatorStyle = .none
        
        
    
    }
    
    
    // Mark - Table View DataSource methods
    // finding the row
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    // pulling out the data from the row and populating data to the table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    
    // MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    //    print(itemArray[indexPath.row])
        
        // this function selects and then deselects the row
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
             tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
    }
    


    
    
    
    
    
    
}

