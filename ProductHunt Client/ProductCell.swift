//
//  ProductCell.swift
//  ProductHunt Client
//
//  Created by Ilya Shigabeev on 20.11.16.
//  Copyright © 2016 Ilya Shigabeev. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var Thumbnail: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!

    @IBOutlet weak var upvotesCount: UILabel!
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
