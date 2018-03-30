//
//  Category.swift
//  Todoey
//
//  Created by Miguel Diez on 3/29/18.
//  Copyright © 2018 Professor Z, LLC. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
