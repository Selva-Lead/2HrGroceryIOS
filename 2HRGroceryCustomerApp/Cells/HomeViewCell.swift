//
//  HomeViewCell.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 05/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class HomeViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var Innerview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        img.layer.borderWidth = 1.0
        img.layer.cornerRadius = 12
        img.clipsToBounds = true
        img.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
        img.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        img.layer.shadowOpacity = 1.0
        img.layer.shadowRadius = 10.0
        
    }

}
