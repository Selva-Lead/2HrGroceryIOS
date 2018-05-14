//
//  ProductVarient.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 11/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import ObjectMapper

class ProductVarient: NSObject, Mappable {
    func mapping(map: Map) {
        strCustomKey <- map["customKey"]
        strImage <- map["image"]
        strItemNo <- map["itemNo"]
        strRegularPrice <- map["regularPrice"]
        strStockStatus <- map["stockStatus"]
        strUnit <- map["unit"]
        strUnitType <- map["unitType"]
        strUpc <- map["upc"]
    }
    
    required init?(map: Map) {
        
    }
    override init() {
        
    }
    
    var strCustomKey: String?
    var strImage: [String:AnyObject] = [String:AnyObject]()
    var strItemNo: String?
    var strRegularPrice: Float?
    var strStockStatus: String?
    var strUnit: String?
    var strUnitType: String?
    var strUpc: String?
    
}
