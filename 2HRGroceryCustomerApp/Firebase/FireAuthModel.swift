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
    
    func getCards() {
        FIRUtils.getSavedCardDBRef().observe(.value, with: {(snapshot) in
            if let value = snapshot.value as? [String: AnyObject]{
                print(value)
                //savedCardsKey = value.keys
                let dic = value.values
                if let singleproduct = Mapper<saveCard>().mapDictionary(JSON: value as! [String : [String : Any]]) { //(JSON: (dic as? [String:AnyObject])!) {
                    print(singleproduct.keys)
                    let keys = singleproduct.flatMap(){ $0.0 as? String }
                    savedCardsKey = keys
                    savedCards = singleproduct
                }
            }
        })
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
        FIRUtils.getCartsDBRef().observeSingleEvent(of: .value, with: { (snapshot) -> Void in //)(.value, with: { (snapshot) -> Void in
            if  let values = snapshot.value as? [String:AnyObject] {
            let sr =  values
                print(sr)
               
                for (key,ele) in sr.enumerated() {

                     let singleAddCart = AddCart()
                    let ee = ele.value as! Dictionary<String, AnyObject> as Dictionary
                    for (kys,els) in ee.enumerated() {
                        print(els.key)
                        if els.key == "id" {
                            singleAddCart.strProductId = els.value as? String
                        }
                        if els.key == "timeStamp" {
                            singleAddCart.strTimeStamp = els.value as? Double
                        }
                        if els.key == "variants" {
                            if  let provarArr = els.value as? NSArray {
                                for (key, value) in provarArr.enumerated() {
                                    print("\(key) and \(value)")
                                    singleAddCart.strVarients = ["\(key)":value  as AnyObject]
                                }
                            } else if let provarDic = els.value as? [String:AnyObject] {
                                singleAddCart.strVarients = provarDic
                            }
                            fullCartList.append(singleAddCart)
                           // singleAddCart.strVarients = els.value as! [String : AnyObject]
                        }
                    }
                    
                }
                print(fullCartList.count)
                complition()
            }
//
//             let provar = snapshot.childSnapshot(forPath: "variants").value
//            if let singleCart = Mapper<AddCart>().map(JSONObject: snapshot.value as! [String:AnyObject]) {
//                print(singleCart)
////                    if  let provarArr = provar as? NSArray {
////                        for (key, value) in provarArr.enumerated() {
////                            print("\(key) and \(value)")
////                            singleCart.strVarients = ["\(key)":"\(value )" as AnyObject]
////                        }
////                    } else if let provarDic = provar as? [String:AnyObject] {
////                        singleCart.strVarients = provarDic
////                    }
////                   // var vartemp : [String: AnyObject] = [String:AnyObject]()
////
////                    print(singleCart)
////                    fullCartList.append(singleCart)
////                    print(fullCartList)
////                    complition()
//                }else {
//                    complition()
//                }
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
    
    func setOrderStatus(status: [String:AnyObject]) {
        FIRUtils.setOrderStatus().updateChildValues(status)
    }
    func setDeliveryDetails(status: [String:AnyObject]) {
        FIRUtils.cartMove().child("deliveryDetails").setValue(strDeliveryDetails)
    }
    
    func cartMoveToBendingCart() {
        // self.ref.child("users").child(user1).child(nodeA).child(nodeToBeMoved).observe(.value, with: {
        
        FIRUtils.cartMove().observe(.value, with: {snapshot in
            let value = snapshot.value as? [String: AnyObject]
            if let actualvalue = value {
                if strCompleted != nil {
                    // self.ref.child(users).child(user1).child(nodeA).child(nodeToBeMoved).removeValue()
                    
                    FIRUtils.pendingCartPath().setValue(actualvalue ) { (error, ref) in
                        
                        FIRUtils.cartMove().setValue(nil)
                    }//setValue(actualvalue as! [String:AnyObject])
                    
                    //                        FIRUtils.pendingCartPath().child("product").setValue(actualvalue["product"] as! [String : AnyObject])
                    //                        FIRUtils.pendingCartPath().child("order").setValue(actualvalue["order"] as! [String : AnyObject])
                    //                    FIRUtils.pendingCartPath().child("deliveryDetails").setValue(actualvalue["deliveryDetails"] as! [String : AnyObject])
                    //self.ref.child(users).child(user2).child(nodeB).child(nodeToBeMoved).child(date).setValue(actualvalue["date"] as Any)
                    
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func storeSetting() {
        FIRUtils.getStoreSettingDBRef().observeSingleEvent(of: .value, with: {(snapshot) in
            if let value = snapshot.value as? [String:AnyObject] {
                storeSettingarr = value
            }
        })
    }
}
