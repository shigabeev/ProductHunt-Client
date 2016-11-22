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
    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var tablView: UITableView!
    @IBOutlet weak var selectedCellLabel: UILabel!
    @IBOutlet weak var CatList: UINavigationItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablView.rowHeight = UITableViewAutomaticDimension
        tablView.estimatedRowHeight = 10
        
        //networking
        network = Network()
        network.get_categories { result in
            print (result)
            self.categories = Util.realm().objects(Category.self)
        }
        print(Util.realm().objects(Category.self).count)
        
        network.get_products { result in
            self.products = Util.realm().objects(Product.self)
            self.tablView.reloadData()

        }
        print(Util.realm().objects(Category.self).count)
        products = Util.realm().objects(Product.self)
        
        let items = ["Tech", "Games", "Podcasts", "Books", "bots"]
        let menuView = BTNavigationDropdownMenu(title: items[0], items: items as [AnyObject])
        self.navigationItem.titleView = menuView
        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            self?.selectedCellLabel.text = items[indexPath]
        }
        
        
        //Dropdown menu
//        let items = Array(categories).map{$0.name}
//        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Tech", items: items as [AnyObject])
//        self.navigationItem.titleView = menuView
//        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
//            print("Did select item at index: \(indexPath)")
//            self?.selectedCellLabel.text = items[indexPath]
//        }
        
        
        //Refresh control
//        refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
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
        cell.productDescription.text = products[indexPath.row].tagline
        cell.upvotesCount.text = "▲ " + String(products[indexPath.row].votes_count)
        cell.imageView?.sd_setImage(with: URL(string: products[indexPath.row].thumbnail!.image_url)!)
        return cell
    }
    
//    func refresh(sender: AnyObject) {
//        refreshBegin("Refresh",
//                     refreshEnd: {(x:Int)->() in
//                        self.tableView.reloadData()
//                        self.refreshControl.endRefreshing()
//        })
//    }
//    func refreshBegin(newtext:String, refreshEnd:(Int) -> ()) {
//        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0).asynchronously() {
//            print("refreshing")
//            self.text = newtext
//            sleep(2)
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                refreshEnd(0)
//            }
//        }
//    }

}

