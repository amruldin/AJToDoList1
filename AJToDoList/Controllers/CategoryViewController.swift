//
//  CategoryViewController.swift
//  AJToDoList
//
//  Created by Amruldin Jamalli on 12/31/17.
//  Copyright © 2017 Amruldin Jamalli. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
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
            
            
            
            
            let newCat = Category(context: self.context)
            
            newCat.name = textField.text!
   
            
            self.categories.append(newCat)
            
            //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            
            self.saveCategories()
            
            
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add Category"
            
            textField = alertTextField
            
        
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    // Writing Data to the Database
    func saveCategories()
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
    func loadCategories()
    {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            categories = try context.fetch(request)
        }
        catch
        {
            print ("Error Fetching the Data \(error)")
        }
        
        
        tableView.reloadData()
        

    }
        
        
        
        
    
    
    
    
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categories.count
        }
        
    
    
    
    
    
    
    
    
    

        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        
    
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
        destinationVC.selectedCategory = categories[indexPath.row]
        
        }
        
        
    }
    
    
    

    


        
        
    
    
    

}

