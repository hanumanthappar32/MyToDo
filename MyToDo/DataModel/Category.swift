//
//  Category.swift
//  MyToDo
//
//  Created by Ramesh H on 14/04/19.
//  Copyright © 2019 Ramesh H. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
    
}
