//
//  Util.swift
//  ProductHunt Client
//
//  Created by Ilya Shigabeev on 20.11.16.
//  Copyright © 2016 Ilya Shigabeev. All rights reserved.
//
import RealmSwift

class Util: Object {

    static let config  = Realm.Configuration(schemaVersion: 4, migrationBlock: {_,_ in })
    
    static func  realm() -> Realm{
        return try! Realm(configuration: Util.config)
    }
    
}
