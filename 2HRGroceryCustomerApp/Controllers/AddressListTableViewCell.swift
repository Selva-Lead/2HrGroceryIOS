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
    @IBOutlet weak var lblCardEnding: UILabel!
    @IBOutlet weak var lblCardExp: UILabel!
    @IBOutlet weak var lblCardBrand: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var ProTitle: UILabel!
    @IBOutlet weak var ProBrand: UILabel!
    @IBOutlet weak var ProLB: UIButton!
    @IBOutlet weak var ProPrice: UILabel!
    @IBOutlet weak var ProCount: UILabel!
    @IBOutlet weak var ProTotalPrice: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    @IBOutlet weak var addCardView: UIView!
    @IBOutlet weak var ExistingCardView: UIView!
    @IBOutlet weak var orderTotalAmount: UILabel!
    @IBOutlet weak var btnDeliveryTimeCheck: UIButton!
    @IBOutlet weak var lblTotalDateandTimeList: UILabel!
    @IBOutlet weak var btnProcessComplete: UIButton!
    
    @IBOutlet weak var btnAddCards: UIButton!
    @IBOutlet weak var deliveryFeeview: UIView!
    @IBOutlet weak var btnAddMoreProduct: UIButton!
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
