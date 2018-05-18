//
//  GroceryVarients.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 18/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class GroceryVarients: NSObject {

    var ProductId: String?
    var ProductDesc: String?
    var ProductName: String?
    var Productbrand: String?
    var Productimage: String?
    var ProductVarient: NSArray?
    
    init(ProductId: String?, ProductDesc: String?, ProductName: String?, Productbrand: String?, Productimage: String?, ProductVarient: NSArray?){
        self.ProductId = ProductId
        self.ProductDesc = ProductDesc
        self.ProductName = ProductName
        self.Productbrand = Productbrand
        self.Productimage = Productimage
        self.ProductVarient = ProductVarient
    }
}
