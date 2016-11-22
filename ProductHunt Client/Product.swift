//
//  Product.swift
//  ProductHunt Client
//
//  Created by Ilya Shigabeev on 20.11.16.
//  Copyright © 2016 Ilya Shigabeev. All rights reserved.
//

import RealmSwift

class Product: Object {
    dynamic var id:Int = 0
    dynamic var name = ""
    dynamic var tagline = ""
    dynamic var thumbnail: Thumbnail?
    dynamic var votes_count = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    
}
