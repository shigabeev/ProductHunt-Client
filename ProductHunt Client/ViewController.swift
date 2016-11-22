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
import DGElasticPullToRefresh

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
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        
        //networking
        network = Network()
        network.get_categories { result in
            print (result)
            self.categories = Util.realm().objects(Category.self)
            let items = Array(self.categories).map{$0.name}
            let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Tech", items: items as [AnyObject])
            self.navigationItem.titleView = menuView
            menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
                print("Did select item at index: \(indexPath)")
                self?.selectedCellLabel.text = items[indexPath]
            }
        }
        print(Util.realm().objects(Category.self).count)
        
        network.get_products { result in
            self.products = Util.realm().objects(Product.self)
            self.tablView.reloadData()
        }
        print(Util.realm().objects(Category.self).count)
        products = Util.realm().objects(Product.self)
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tablView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            // Add your logic here
            self?.network.get_products { result in
                self?.products = Util.realm().objects(Product.self)
                self?.tablView.reloadData()
            }
            print(Util.realm().objects(Category.self).count)
            self?.products = Util.realm().objects(Product.self)

            // Do not forget to call dg_stopLoading() at the end
            self?.tablView.dg_stopLoading()
            }, loadingView: loadingView)
        tablView.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        tablView.dg_setPullToRefreshBackgroundColor(tablView.backgroundColor!)

        
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
    
    
}

