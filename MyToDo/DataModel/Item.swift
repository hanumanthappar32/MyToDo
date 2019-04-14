//
//  Item.swift
//  MyToDo
//
//  Created by Ramesh H on 14/04/19.
//  Copyright © 2019 Ramesh H. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
