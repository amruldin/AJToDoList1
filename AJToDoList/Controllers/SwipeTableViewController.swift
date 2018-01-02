//
//  SwipeTableViewController.swift
//  AJToDoList
//
//  Created by Amruldin Jamalli on 1/1/18.
//  Copyright © 2018 Amruldin Jamalli. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

       tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        
        
    }
    
    // Table View Data Source Mthods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
   

    // MARK : - Swipe Cell Delegate Method
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            
            self.updateModel(at: indexPath)
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
            //tableView.reloadData()
            
            
            
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        //options.transitionStyle = .border
        return options
    }
    
    func updateModel (at indexPath: IndexPath)
    {
        // Update Data model
        
        
    }
    
    
}
    

