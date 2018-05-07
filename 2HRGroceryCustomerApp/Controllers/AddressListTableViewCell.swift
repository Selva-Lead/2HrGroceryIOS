//
//  AddressListTableViewCell.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 04/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class AddressListTableViewCell: UITableViewCell {

    @IBOutlet weak var addrName: groceryText!
    @IBOutlet weak var lbladdrDetail: UILabel!
    @IBOutlet weak var vewDateAndTime: UIView!
    @IBOutlet weak var btnCreditcard: UIButton!
    @IBOutlet weak var txtPaymentDate: groceryText!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //vewDateAndTime.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
       // vewDateAndTime.layer.shadowOffset = CGSize(width: 0, height: 2.0)
       
    }

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
