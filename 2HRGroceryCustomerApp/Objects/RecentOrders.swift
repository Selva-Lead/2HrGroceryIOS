//
//  RecentOrders.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 14/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class RecentOrders: NSObject {

    var ProductId: String?
    var RecentTimeStamp: Int?
    
    init(ProductId: String?, RecentTimeStamp: Int?){
        self.ProductId = ProductId
        self.RecentTimeStamp = RecentTimeStamp
    }
}
