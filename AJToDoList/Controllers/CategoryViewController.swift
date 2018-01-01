//
//  CategoryViewController.swift
//  AJToDoList
//
//  Created by Amruldin Jamalli on 12/31/17.
//  Copyright © 2017 Amruldin Jamalli. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    
    var categories : Results<Category>?
    
    //result is a container provided by realm
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
       


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
        
        
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//
//        do{
//            categories = try context.fetch(request)
//        }
//        catch
//        {
//            print ("Error Fetching the Data \(error)")
//        }
//
        
        tableView.reloadData()
        

    }
        
        
        
        
    
    
    
    
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // the below lines is equal to say if the category.count wasn't 0 then return its value otherwise
        // return 1. The syntax is called Nil Coalescing Operator
        return categories?.count ?? 1
        }
        
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
    
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category Added Yet"
        
        
    
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

