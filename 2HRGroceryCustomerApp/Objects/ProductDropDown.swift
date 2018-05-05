//
//  ProductDropDown.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 04/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class ProductDropDown: NSObject {

    var ProductId: String?
    var ProductDesc: String?
    var ProductName: String?
    var Productbrand: String?
    var Productimage: String?
    
   // override init() {
   //     super.init()
    init(ProductId: String?, ProductDesc: String?, ProductName: String?, Productbrand: String?, Productimage: String?){
        self.ProductId = ProductId
        self.ProductDesc = ProductDesc
        self.ProductName = ProductName
        self.Productbrand = Productbrand
        self.Productimage = Productimage
    }
}
