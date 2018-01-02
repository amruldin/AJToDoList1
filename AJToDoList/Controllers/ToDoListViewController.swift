//
//  ViewController.swift
//  AJToDoList
//
//  Created by Amruldin Jamalli on 12/30/17.
//  Copyright © 2017 Amruldin Jamalli. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import ChameleonFramework


class ToDoListViewController: SwipeTableViewController{
    
    let realm = try! Realm()
    
    var toDoItems : Results <Item>?
    var selectedCategory : Category? {
        
        didSet{
           loadItems()
        }
        
    }
    
    
     //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
     // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   // let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let preferredColor = UIColor(hexString: (selectedCategory?.color)!)
        {
        navigationController?.navigationBar.tintColor = preferredColor
        }
        
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
        return toDoItems?.count ?? 1
    }
    
    
    
    
    // pulling out the data from the row and populating data to the table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = toDoItems?[indexPath.row].title ?? "No Category Added Yet"
        
       // let categoryColor = UIColor(HexString: selectedCategory?.color)
        
        let color =  UIColor(hexString: (selectedCategory?.color)!)?.darken(byPercentage: ((CGFloat(indexPath.row)/CGFloat((toDoItems?.count)!))))
        cell.backgroundColor = color
        
        cell.textLabel?.textColor = ContrastColorOf(color!, returnFlat: true)
        // cell.delegate = self
        
        
        return cell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
//
//        if let item = toDoItems?[indexPath.row]
//        {
//            cell.textLabel?.text = item.title
//
//            // Ternary Operator ==>
//            // Value = condition ? valueIfTrue : valueIfFalse
//
//            cell.accessoryType = item.done  ? .checkmark : .none
//
//        }
//        else
//        {
//            cell.textLabel?.text = "No Item Added Yet"
//        }
//
        

    }
    
    

    
    
    
    
    
    // MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       // updateModel(at: indexPath)
        // updating items using realm
//        if let item = toDoItems?[indexPath.row]
//        {
//            do{
//            try realm.write {
//               // realm.delete(item) this function will delete items
//                item.done = !item.done
//            }
//            }
//            catch
//            {
//                print("Error Data Saving Status, \(error)")
//            }
//        }
        
        
//
        tableView.reloadData()
        
    
        
        // this function selects and then deselects the row
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    override func updateModel(at indexPath: IndexPath) {
        
        
        
        if let cat = toDoItems?[indexPath.row]
        {
            do{
                try self.realm.write {
                    self.realm.delete(cat)
                    
                }
            }
            catch
            {
                print("Error Data Saving Status, \(error)")
            }
        }
        // tableView.reloadData()
    }
    
    
    // MARK -  ADD New Items Section
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Item", message: "",
                                      preferredStyle: .alert)
       
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // Things that happends when user clicks on the add item
       
           // writing data using realm
            if let currentCategory = self.selectedCategory
            {
                do {
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dataCreated = Date()
                    currentCategory.items.append(newItem)
                }
                }
                catch
                {
                    print("Error saving items \(error)")
                    
                }
                
                self.tableView.reloadData()

        }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add task"
            
            textField = alertTextField
         
        }
      
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

        
        
    }
    
    
    
    // Reading Data from the Database
    func loadItems()
    {
        
        
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
 
}
    
}
    
    
//
//    // MARK - UI search bar Delegate Methods
extension ToDoListViewController : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        
        
        toDoItems = toDoItems?.filter("title CONTAINS [cd] %@", searchBar.text!).sorted(byKeyPath: "dataCreated", ascending: true)
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


