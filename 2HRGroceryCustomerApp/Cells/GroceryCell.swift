//
//  GroceryCell.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 23/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class GroceryCell: UICollectionViewCell {

    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var BrandLbl: UILabel!
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var addcartbtn: UIButton!
    @IBOutlet weak var dropview: UIView!
    @IBOutlet weak var productdropbtn: UIButton!
    @IBOutlet weak var varientlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
