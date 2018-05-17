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
                var productVarientDic: [ProductVarient] = [ProductVarient]()
                if  let productVar = snapshot.childSnapshot(forPath: "productVariant").value  {
                    var tempProArr = NSArray()
                    tempProArr = productVar as! NSArray
                    for object in tempProArr{
                        var tempdic = ProductVarient()
                        let dic = object as! NSDictionary
                        tempdic.strCustomKey = dic.value(forKey: "customKey") as? String
                        tempdic.strImage = dic.value(forKey: "image") as! Dictionary
                        tempdic.strItemNo = dic.value(forKey: "itemNo") as? String
                        tempdic.strRegularPrice = dic.value(forKey: "regularPrice") as? Float
                        tempdic.strStockStatus = dic.value(forKey: "stockStatus") as? String
                        tempdic.strUnit = dic.value(forKey: "unit") as? String
                        tempdic.strUnitType = dic.value(forKey: "unitType") as? String
                        tempdic.strUpc = dic.value(forKey: "upc") as? String
                        productVarientDic.append(tempdic)
                    }
                }
               // productForSaleItems = value as! [String : ProductDropDown]
                if let singleproduct = Mapper<ProductForSale>().map(JSON: value) {
                    print(singleproduct)
                    let id = singleproduct.strProductId
                    singleproduct.strProductVarients = productVarientDic
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
    func removeCarts(productForSAleID: String) {
        FIRUtils.addCartDBRef(productId: productForSAleID).removeValue()
    }
    func getCartList(complition: @escaping () -> (Swift.Void)) {
        fullCartList.removeAll()
//        FIRUtils.getCartsDBRef().observe(.childChanged, with: { snapshot -> Void in
//             let provar = snapshot.childSnapshot(forPath: "variants").value
//            if let value = snapshot.value as? [String: Any] {
//                if let singleCart = Mapper<AddCart>().map(JSON: value) {
//                    let provarArr = provar as! NSArray
//                    var vartemp : [String: AnyObject] = [String:AnyObject]()
//                    for (key, value) in provarArr.enumerated() {
//                        print("\(key) and \(value)")
//                        singleCart.strVarients = ["\(key)":"\(value )" as AnyObject]
//                    }
//                    print(singleCart)
//                    fullCartList = [singleCart]
//                    print(fullCartList)
//                    complition()
//                }
//                
//            }
//        })
//        FIRUtils.getCartsDBRef().observe(.childRemoved, with: { snapshot in
//             let provar = snapshot.childSnapshot(forPath: "variants").value
//            if let value = snapshot.value as? [String: Any] {
//                if let singleCart = Mapper<AddCart>().map(JSONObject: value) {
//                    let provarArr = provar as! NSArray
//                    var vartemp : [String: AnyObject] = [String:AnyObject]()
//                    for (key, value) in provarArr.enumerated() {
//                        print("\(key) and \(value)")
//                        singleCart.strVarients = ["\(key)":"\(value )" as AnyObject]
//                    }
//                    print(singleCart)
//                    fullCartList = [singleCart]
//                    print(fullCartList)
//                    complition()
//                }
//                
//            }
//        })
        FIRUtils.getCartsDBRef().observe(.childAdded, with: { (snapshot) -> Void in
            let provar = snapshot.childSnapshot(forPath: "variants").value
                if let singleCart = Mapper<AddCart>().map(JSONObject: snapshot.value) {
                    if  let provarArr = provar as? NSArray {
                        for (key, value) in provarArr.enumerated() {
                            print("\(key) and \(value)")
                            singleCart.strVarients = ["\(key)":"\(value )" as AnyObject]
                        }
                    } else if let provarDic = provar as? [String:AnyObject] {
                        singleCart.strVarients = provarDic
                    }
                   // var vartemp : [String: AnyObject] = [String:AnyObject]()
                   
                    print(singleCart)
                    fullCartList.append(singleCart)
                    print(fullCartList)
                    complition()
                }else {
                    complition()
                }
        })
    }

    func getDeliveryFee() {
        FIRUtils.getstroeDeliveryFeeDBRef().observe(.value, with: {(snapshot) in
            if let value = snapshot.value as? [String:AnyObject] {
                deliveryfeeArr = value
            }
        })
    }
    
    func getAddressList() {
        FIRUtils.getAddressListDBRef().observe(.value, with: {(snapshot) in
            if let value = snapshot.value  {
                let temAddressArr = value as! NSArray
                for object in temAddressArr{
                    var tempdic = AddressList()
                    let dic = object as! NSDictionary
                    tempdic.strAddress = dic.value(forKey: "address") as? String
                    tempdic.strCity = dic.value(forKey: "city") as? String
                    tempdic.strFullAddress = dic.value(forKey: "fulladdress") as? String
                    tempdic.strState = dic.value(forKey: "state") as? String
                    tempdic.strZip = dic.value(forKey: "zip") as? String
                    customAddressList.append(tempdic)
                }
                //            if let singleCart = Mapper<AddressList>().mapArray(JSONfile: snapshot.value as! String) {
                //                    customAddressList = singleCart
                //                }
            }
        })
    }

    func setdefaultAddress(addcount: String, value: AddressList) {
        FIRUtils.getAddressListDBRef().child(addcount).setValue(value.toJSON())
    }
    func getAvaialbility() {
        FIRUtils.getAvailabitityTime().observe(.value, with: {(snapshot) in
            print(snapshot.value)
            if let value = snapshot.value  {
                availabilityTimes = value as! NSArray
            }
        })
       
    }
}
