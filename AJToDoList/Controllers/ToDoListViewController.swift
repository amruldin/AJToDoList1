//
//  ViewController.swift
//  AJToDoList
//
//  Created by Amruldin Jamalli on 12/30/17.
//  Copyright © 2017 Amruldin Jamalli. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController{
    

    var itemArray = [Item]()
    var selectedCategory : Category? {
        
        didSet{
            loadItems()
        }
        
    }
    
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
      let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   // let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // setting up UI Searchbar delegate
        
        
        
        
       
        

        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]
//        {
//            itemArray = items
//        }
        
  
        
      
     
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
        
        // the follwoing line of code will help you update the content
       // itemArray[indexPath.row].setValue("Dell", forKey: "title")
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
//
        
        
        
        saveItems()
        
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
        
      //  tableView.reloadData()
        
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
            
          
            
     
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            self.itemArray.append(newItem)
            
           //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            
            self.saveItems()
            
            
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add task"
            
            textField = alertTextField
         
            
           
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

        
        
    }
    
    
    // Writing Data to the Database
    func saveItems()
    {
        //let encoder = PropertyListEncoder()
        
        
        do{
            try context.save()
    
        }
        catch
        {
            print("Error saving Item Array, \(error)")
        }
        self.tableView.reloadData()
    }
    

    
    
    // Reading Data from the Database
    func loadItems()
    {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        request.predicate = predicate
        
        do{
        itemArray = try context.fetch(request)
        }
        catch
        {
            print ("Error Fetching the Data \(error)")
        }
        
        
        tableView.reloadData()
        
//        if let data = try? Data(contentsOf: dataFilePath!)
//        {
//            let decoder = PropertyListDecoder()
//
//            do {
//            itemArray = try decoder.decode([Item].self, from: data)
//            }
//            catch{
//                print(error)
//
//            }
//        }
    }

}

    // MARK - UI search bar Delegate Methods
extension ToDoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest <Item> = Item.fetchRequest()
        
        
        // forming query [cd] makes the query insensitive case and diacritic
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.predicate = predicate
        
        // we can sort the query
        let sortDescriptr = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sortDescriptr]
        
        // Now load the data
       
        do {
            itemArray = try context.fetch(request)
        }
        catch
        {
            print ("Error Fetching the Data \(error)")
        }
        
        tableView.reloadData()
        
        
    }
    
    // New Delegate Method
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
         if searchBar.text?.count == 0
         {
            loadItems()
            
            DispatchQueue.main.async {
                 searchBar.resignFirstResponder()
            }
           
            
            
        }
    }
    
    
}


