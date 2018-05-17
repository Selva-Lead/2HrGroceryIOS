//
//  AddressList.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 16/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import ObjectMapper

class AddressList: NSObject, Mappable {
    func mapping(map: Map) {
        strAddress <- map["address"]
        strCity <- map["city"]
        strFullAddress <- map["fulladdress"]
        strState <- map["state"]
        strZip <- map["zip"]
       
    }
    
    required init?(map: Map) {
        
    }
    override init() {
        
    }
    
    var strAddress: String?
    var strCity: String?
    var strFullAddress: String?
    var strState: String?
    var strZip: String?
}
