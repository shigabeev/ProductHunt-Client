//
//  ViewController.swift
//  ProductHunt Client
//
//  Created by Ilya Shigabeev on 15.11.16.
//  Copyright © 2016 Ilya Shigabeev. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage
import BTNavigationDropdownMenu


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var network:Network!
    var products:Results<Product>!
    var categories:Results<Category>!
    
    @IBOutlet weak var tablView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablView.rowHeight = UITableViewAutomaticDimension
        tablView.estimatedRowHeight = 10
        
        //networking
        network = Network()
        network.get_categories { result in
            print (result)
        }
        print(Util.realm().objects(Category.self).count)
        
        network.get_products { result in
            self.products = Util.realm().objects(Product.self)
            self.tablView.reloadData()

        }
        print(Util.realm().objects(Category.self).count)
        products = Util.realm().objects(Product.self)
        
//        let items = Array(categories).map{$0.name}
        
     //Dropdown menu
//        
//        
//        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Tech", items: items as [AnyObject])
//        
//        self.navigationItem.titleView = menuView
//        
//        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
//            print("Did select item at index: \(indexPath)")
//        }
//        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.productTitle.text = products[indexPath.row].name
        cell.imageView?.sd_setImage(with: URL(string: products[indexPath.row].thumbnail!.image_url)!)
        cell.imageView!.clipsToBounds = true
        return cell
    }

}

