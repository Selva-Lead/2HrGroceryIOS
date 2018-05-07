//
//  saveCard.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 07/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import ObjectMapper

class saveCard: NSObject, Mappable {
    func mapping(map: Map) {
        strBrand <- map["brand"]
    }
    
    required init?(map: Map) {
        
    }
    
    var strBrand: String?
    var strExpMonth: String?
    var strExpDate: String?
    var strLastFour: String?
}
