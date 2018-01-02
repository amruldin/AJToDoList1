//
//  Category.swift
//  AJToDoList
//
//  Created by Amruldin Jamalli on 12/31/17.
//  Copyright © 2017 Amruldin Jamalli. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object
{
   @objc dynamic var name : String = ""
    @objc dynamic var color : String = ""
    
    let items = List<Item>()
    
    
    
    
}
