//
//  ViewController.swift
//  AJToDoList
//
//  Created by Amruldin Jamalli on 12/30/17.
//  Copyright © 2017 Amruldin Jamalli. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]
        {
            itemArray = items
        }
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "dd"
        itemArray.append(newItem1)
     
        // Do any additional setup after loading the view, typically from a nib.
   
    //tableView.separatorStyle = .none
        
        
    
    }
    
    
    // Mark - Table View DataSource methods
    // finding the row
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    // pulling out the data from the row and populating data to the table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        // Ternary Operator ==>
        // Value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done  ? .checkmark : .none
        
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        }
//        else
//        {
//            cell.accessoryType = .none
//
//        }
//
        return cell
        
    }
    
    
    // MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    //    print(itemArray[indexPath.row])
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        // the above line means the same thing
//        if itemArray[indexPath.row].done == false
//
//        {
//            itemArray[indexPath.row].done = true
//
//        }
//        else
//        {
//            itemArray[indexPath.row].done = false
//        }
//
        
        tableView.reloadData()
        
        // this function selects and then deselects the row
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    // MARK -  ADD New Items Section
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Item", message: "",
                                      preferredStyle: .alert)
       
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // Things that happends when user clicks on the add item
     
            let newItem = Item()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
           // self.defaults.set(self.itemArray, forKey: "ToDoListArray")
        
            
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

