//
//  Item.swift
//  AJToDoList
//
//  Created by Amruldin Jamalli on 12/31/17.
//  Copyright © 2017 Amruldin Jamalli. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object
{
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dataCreated : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
    
}
