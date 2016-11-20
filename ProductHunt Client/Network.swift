//
//  Network.swift
//  ProductHunt Client
//
//  Created by Ilya Shigabeev on 20.11.16.
//  Copyright © 2016 Ilya Shigabeev. All rights reserved.
//
import RealmSwift
import Alamofire

class Network: Object {
    static let BACKEND = "https://api.producthunt.com/v1/"
    
    let Categories = Network.BACKEND + "categories/"
    let Products = Network.BACKEND + "posts/all"
    let Parameters = ["access_token":"591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"]
    
    
    func get_categories(completion: ((Bool)->())?){
        Alamofire.request(Categories, method: .get, parameters:Parameters, encoding: JSONEncoding.default).responseJSON { response in
            print (response)
            if let json = response.result.value as? NSDictionary {
                if let categories = json["categories"] as? NSArray {
                   let realm = Util.realm()
                    try! realm.write {
                        for item in categories {
                            realm.create(Category.self, value: item, update:true)
                        }
                    }
                    completion?(true)
                }
            }
            
        }
    }
    
    func get_products(completion: ((Bool)->())?){
        Alamofire.request(Products, method: .get, parameters:Parameters, encoding: JSONEncoding.default).responseJSON { response in
            print (response)
            if let json = response.result.value as? NSDictionary {
                if let posts = json["posts"] as? NSArray {
                    let realm = Util.realm()
                    try! realm.write {
                        for item in posts {
                            realm.create(Product.self, value: item, update:true)
                        }
                    }
                    completion?(true)
                }
            }
        }
    }

    
}
