//
//  AddCart.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 09/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import ObjectMapper

class AddCart: NSObject, Mappable {
    func mapping(map: Map) {
        strProductId <- map["id"]
        strTimeStamp <- map["timeStamp"]
        strVarients <- map["variants"]
        
    }
    
    required init?(map: Map) {
        
    }
    override init() {
        
    }
    
    var strProductId: String?
    var strTimeStamp: Double?
    var strVarients: [String:AnyObject] = [String:AnyObject]()

}
