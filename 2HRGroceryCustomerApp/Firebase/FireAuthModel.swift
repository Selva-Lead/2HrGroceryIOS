//
//  FireAuthModel.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 07/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import ObjectMapper

class FireAuthModel: NSObject {
    func getProductForSale() {
        FIRUtils.getProductForSaleDBRef().observe(.childAdded, with: {snapshot in
            if let value = snapshot.value as? [String:AnyObject] {
               // productForSaleItems = value as! [String : ProductDropDown]
                if let singleproduct = Mapper<ProductForSale>().map(JSON: value) {
                    print(singleproduct)
                    let id = singleproduct.strProductId
                    print(id)
                    productForCart[id!] = singleproduct
                    print(productForCart)
                   
                }
            }
        })
    }
    func saveCards(CustomerId: String, Token: String,valueSaveCard:saveCard, compition:@escaping ((Error?) -> ())) {
        FIRUtils.saveCardDBRef(customerId: CustomerId, uid: Token).setValue(valueSaveCard.toJSON()) { (error,reference) in
            if error != nil {
                compition(error)
            }else{
                compition(nil)
            }
            
        }
    }
    func addCarts(productForSaleID: String,valueAddCart:AddCart){
        FIRUtils.addCartDBRef(productId: productForSaleID).setValue(valueAddCart.toJSON())
    }
    func getCartList(complition: @escaping () -> (Swift.Void)) {
        fullCartList.removeAll()
        FIRUtils.getCartsDBRef().observe(.childChanged, with: { snapshot -> Void in
           
            if let value = snapshot.value as? [String: Any] {
                 //print(snapshot.value as AnyObject)
                if let singleCart = Mapper<AddCart>().map(JSONObject: value) {
                    print(singleCart)
                    fullCartList = [singleCart]
                    print(fullCartList)
                    complition()
                }
                
            }
        })
        FIRUtils.getCartsDBRef().observe(.childRemoved, with: { snapshot in
            
            if let value = snapshot.value as? [String: Any] {
                //print(snapshot.value as AnyObject)
                if let singleCart = Mapper<AddCart>().map(JSONObject: value) {
                    print(singleCart)
                    fullCartList = [singleCart]
                    print(fullCartList)
                    complition()
                }
                
            }
        })
        FIRUtils.getCartsDBRef().observe(.childAdded, with: { snapshot in
            
            if let value = snapshot.value as? [String: Any] {
                //print(snapshot.value as AnyObject)
                if let singleCart = Mapper<AddCart>().map(JSONObject: value) {
                    print(singleCart)
                    fullCartList.append(singleCart)
                    print(fullCartList)
                    complition()
                }else {
                    complition()
                }
                
            }
        })
    }
}
