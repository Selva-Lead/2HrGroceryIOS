//
//  groceryText.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 04/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class groceryText: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.shadowColor =  UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
        self.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        self.layer.borderWidth = 1.0
        self.font = UIFont(name: "Gibson,Regular", size: 14)
        //self.textColor = UIColor(red: 69, green: 79, blue: 99, alpha: 1)
        self.textAlignment = .left
        //self.backgroundColor = UIColor(red:112, green:112, blue:112, alpha:0.21)
        
    }

}
