//
//  ViewController.swift
//  AJToDoList
//
//  Created by Amruldin Jamalli on 12/30/17.
//  Copyright © 2017 Amruldin Jamalli. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    

    var itemArray = ["Call Him", "Call Bob", "BootCamp Meeting"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]
        {
            itemArray = items
        }
        
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
    
    // MARK -  ADD New Items Section
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Item", message: "",
                                      preferredStyle: .alert)
       
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // Things that happends when user clicks on the add item
            print("Success")
           
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
        
            
            self.tableView.reloadData()
            
            
            
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add task"
            
            textField = alertTextField
         
            
           
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

        
        
    }
    
    


    
    
    
    
    
    
}

