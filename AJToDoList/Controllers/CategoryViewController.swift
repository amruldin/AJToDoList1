//
//  CategoryViewController.swift
//  AJToDoList
//
//  Created by Amruldin Jamalli on 12/31/17.
//  Copyright © 2017 Amruldin Jamalli. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    
    var categories : Results<Category>?
    
    //result is a container provided by realm
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
      //  tableView.rowHeight = 80.0
        
       

    }

 

    
    
    //MARK: - Add Category Button selected
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Category", message: "",
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            // Things that happends when user clicks on the add item
            
            
            
            
            let newCat = Category()
            
            newCat.name = textField.text!
            newCat.color = UIColor.randomFlat.hexValue()
   
            
          //  self.categories.append(newCat)
            
            //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            
            self.saveCategories(category: newCat)
            
            
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add Category"
            
            textField = alertTextField
            
        
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    // Writing Data to the Database
    func saveCategories(category : Category)
    {
        //let encoder = PropertyListEncoder()
        
        
        do{
            try realm.write {
                realm.add(category)
            }
            
        }
        catch
        {
            print("Error saving Item Array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    
    
    // Reading Data from the Database
    func loadCategories()
    {
        
       // let categories = realm.objects(Category.self)
        
        categories = realm.objects(Category.self)
        

        tableView.reloadData()
        

    }
    
    //MARK: - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        
        
        
                    if let cat = self.categories?[indexPath.row]
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
        
        
        
    
    
    
    
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // the below lines is equal to say if the category.count wasn't 0 then return its value otherwise
        // return 1. The syntax is called Nil Coalescing Operator
        return categories?.count ?? 1
        }
        
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
      //  let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        
    
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category Added Yet"
        
        
        
       // cell.delegate = self
        
        cell.backgroundColor = UIColor(hexString: (categories?[indexPath.row].color ?? "1D9BF6"))
    
        return cell
        
        
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
       if let indexPath = tableView.indexPathForSelectedRow
       {
        destinationVC.selectedCategory = categories?[indexPath.row]
        
        }
        
        
    }
    

}

// MARK : - Swipe Cell Delegate Method

//extension CategoryViewController: SwipeTableViewCellDelegate
//{
//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//            // handle action by updating model with deletion
//
//
//            if let cat = self.categories?[indexPath.row]
//            {
//                do{
//                    try self.realm.write {
//                        self.realm.delete(cat)
//
//                    }
//                }
//                catch
//                {
//                    print("Error Data Saving Status, \(error)")
//                }
//            }
//            //tableView.reloadData()
//
//
//
//        }
//
//        // customize the action appearance
//        deleteAction.image = UIImage(named: "delete-icon")
//
//        return [deleteAction]
//    }
//
//
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
//        var options = SwipeTableOptions()
//        options.expansionStyle = .destructive
//        //options.transitionStyle = .border
//        return options
//    }
//
//
//}

