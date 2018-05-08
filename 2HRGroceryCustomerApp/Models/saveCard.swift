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
        strExpMonth <- map["exp_month"]
        strExpYear <- map["exp_year"]
        strLastFour <- map["last4"]
    }
    
    required init?(map: Map) {
        
    }
    override init() {
        
    }
    
    var strBrand: String?
    var strExpMonth: Int?
    var strExpYear: Int?
    var strLastFour: String?
}
