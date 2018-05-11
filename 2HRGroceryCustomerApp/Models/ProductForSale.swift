//
//  ProductForSale.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 10/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import ObjectMapper

class ProductForSale: NSObject, Mappable {
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        strProductId <- map["productID"]
        strProductDesc <- map["description"]
        strProductName <- map["name"]
        strProductbrand <- map["brand"]
        strProductimage <- map["image"]
    }
    

    var strProductId: String?
    var strProductDesc: String?
    var strProductName: String?
    var strProductbrand: String?
    var strProductimage: [String:AnyObject] = [String: AnyObject]()
    var strProductVarients: [String:AnyObject] = [String: AnyObject]()
}
