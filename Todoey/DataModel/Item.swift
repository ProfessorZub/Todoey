//
//  Item.swift
//  Todoey
//
//  Created by Miguel Diez on 3/29/18.
//  Copyright © 2018 Professor Z, LLC. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
 //   @objc dynamic var dateCreated : Date = Date(timeIntervalSince1970: 0)
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
