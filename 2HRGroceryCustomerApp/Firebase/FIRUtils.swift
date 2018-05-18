//
//  FIRUtils.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 07/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import Firebase

class FIRUtils: NSObject {
    struct FBPath {
        static let customerList = "/Customer-List/"
        static let savedCards = "/savedCards/"
        static let cart = "/cart/"
        static let product = "/product/"
        static let productForSale = "/productsForSale/"
        static let storeSettingdeliveryFee = "/storeSetting/2HRGroceryLLC/deliveryFee/0/"
        static let address = "/address/"
        static let availabitity = "/Availability/regularHours"
        
    }
    
    class func  saveCardDBRef(customerId: String,uid : String) -> DatabaseReference {
        return Database.database().reference().child(FBPath.customerList).child(customerId).child(FBPath.savedCards).child(uid)
    }
    class func getSavedCardDBRef() -> DatabaseReference {
        return Database.database().reference().child(FBPath.customerList).child(useruid).child(FBPath.savedCards)
    }
    class func addCartDBRef(productId :String) -> DatabaseReference {
    return Database.database().reference().child(FBPath.customerList).child(useruid).child(FBPath.cart).child(FBPath.product).child(productId
        )
    }
    class func getCartsDBRef() -> DatabaseReference {
        return Database.database().reference().child(FBPath.customerList).child(useruid).child(FBPath.cart).child(FBPath.product)
    }
    class func getProductForSaleDBRef() -> DatabaseReference {
        return Database.database().reference().child(FBPath.productForSale)
    }
    class func getstroeDeliveryFeeDBRef() -> DatabaseReference {
        return Database.database().reference().child(FBPath.storeSettingdeliveryFee)
    }
    class func getAddressListDBRef() -> DatabaseReference {
        return Database.database().reference().child(FBPath.customerList).child(useruid).child(FBPath.address)
    }
    class func getAvailabitityTime() -> DatabaseReference {
        return Database.database().reference().child(FBPath.availabitity)
    }
}
