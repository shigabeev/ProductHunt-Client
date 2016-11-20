//
//  Category.swift
//  ProductHunt Client
//
//  Created by Ilya Shigabeev on 20.11.16.
//  Copyright © 2016 Ilya Shigabeev. All rights reserved.
//

import RealmSwift

class Category: Object {
    dynamic var id = 0
    dynamic var slug = ""
    dynamic var name = ""
    dynamic var color = ""
    dynamic var item_name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
