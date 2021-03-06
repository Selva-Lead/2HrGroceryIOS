//
//  OrderConformationViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 07/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class OrderConformationViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
     @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "View", bundle: nil)
        self.tblView.register(nib, forHeaderFooterViewReuseIdentifier: "PaymentHeader")
        // Do any additional setup after loading the view.
       
        topView.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        topView.layer.borderWidth = 0.5
        topView.layer.shadowColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        topView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        topView.layer.shadowOpacity = 1.0
        topView.layer.shadowRadius = 10.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func placeOrder() {
        if deliveryOption == 1 {
            
        }
    }
    func deliveryPlaceOrder() {
        strCheckout = nil
        print(seleDateWithYear)
        let sepratedString = seleDateWithYear?.split(separator: .init(" ") )
        let strDate = sepratedString![0].appending(" ")
        let strStartTime = sepratedString![4].appending(":00")
        let strEndTime = sepratedString![6].appending(":00")
        //  let sepratedString = selectedDateandTime?.split(separator: "-") //(in: .alphanumerics)
        var strtimes = [String:AnyObject]()
        strtimes["startTime"] = strDate.appending(" ").appending(strStartTime) as AnyObject//"2018-05-25 12:00" as AnyObject
        strtimes["endTime"] = strDate.appending(" ").appending(strEndTime) as AnyObject//"2018-05-25 14:00" as AnyObject
        strCompleted = "complete"
        // var customaddress = [str]()
        //customaddres = customAddressList[0]
        
        strDeliveryDetails["address"] = customAddressList[0].toJSON() as AnyObject
        strDeliveryDetails["deliveryTime"] = strtimes as AnyObject
        if deliveryOption == 1 {
            strDeliveryDetails["deliveryType"] = "Delivery" as AnyObject
        }else {
            strDeliveryDetails["deliveryType"] = "Pickup" as AnyObject
        }
        var strValues = [String : AnyObject]()
        strValues["token"] = (savedCardsKey[selectedCard]) as AnyObject
        strValues["total"] = totalCheckOutPrice as AnyObject
        let date = Date() // Get Todays Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let stringDate: String = dateFormatter.string(from: date as Date)
        print(stringDate)
        strValues["time"] = stringDate as AnyObject//"2018-05-21T10:13:26-04:00" as AnyObject// NSTimeIntervalSince1970 as AnyObject
        strValues["status"] = "complete" as AnyObject
        strValues["newCard"] = true as AnyObject
        strValues["saveForLater"] = false as AnyObject
        
        
        
        FireAuthModel().setOrderStatus(status: strValues)
        FireAuthModel().setDeliveryDetails(status: strDeliveryDetails)
        FireAuthModel().cartMoveToBendingCart()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ThankyouViewController") as! ThankyouViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @objc func addMoreProduct() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
extension OrderConformationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "CUSTOMER NAME"
        } else if section == 1 {
            return "DELIVERY ADDRESS"
        } else if section == 2 {
            return "Delivery Date & Time"
        } else if section == 3 {
            return "Payment Method"
        } else if section == 4 {
            return "Items in the Card"
        }else {
            return ""
        }
    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if section == 5 {
//            return 0
//        }else if section == 6 {
//            return 0
//        }else {
//            return 35
//        }
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            return fullCartList.count
        }else {
            return 1
        }
    }
    

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellName") as! AddressListTableViewCell
    let celldetail = tableView.dequeueReusableCell(withIdentifier: "cellAddress") as! AddressListTableViewCell
    let cellPaymentDate = tableView.dequeueReusableCell(withIdentifier: "cellPaymentDate") as! AddressListTableViewCell
    let cellCard = tableView.dequeueReusableCell(withIdentifier: "cellCard") as! AddressListTableViewCell
    let cellProductItem = tableView.dequeueReusableCell(withIdentifier: "cellProductDetails") as! AddressListTableViewCell
    let cellMore = tableView.dequeueReusableCell(withIdentifier: "cellMoreProduct") as! AddressListTableViewCell
    let cellPlaceOrder = tableView.dequeueReusableCell(withIdentifier: "cellPlaceOrder") as! AddressListTableViewCell
    cell.selectionStyle = .none
    celldetail.selectionStyle = .none
    cellPaymentDate.selectionStyle = .none
    cellCard.selectionStyle = .none
    cellProductItem.selectionStyle = .none
    cellMore.selectionStyle = .none
    cellPlaceOrder.selectionStyle = .none
    if indexPath.section == 0 {
        cell.addrName.text = UserDisplayName
        return cell
    }else if indexPath.section == 1 {
        celldetail.lbladdrDetail.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        celldetail.lbladdrDetail.layer.borderWidth = 1.0
        celldetail.lbladdrDetail.text = customAddressList[0].strFullAddress
        return celldetail
    }else if indexPath.section == 2 {
        cellPaymentDate.txtPaymentDate.text = selectedDateandTime
        //cellPaymentDate.vewDateAndTime.layer.borderWidth = 1.0
        //cellPaymentDate.vewDateAndTime.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
        return cellPaymentDate
    } else if indexPath.section == 3 {
        return cellCard
    } else if indexPath.section == 4 {
        var singleAddCart = AddCart()
        print("indexpath row \(indexPath.row)")
        singleAddCart = fullCartList[indexPath.row]
        let varients = singleAddCart.strVarients
        let product = productForCart[singleAddCart.strProductId!]
        let singleVarientsKey = Int((varients.first?.key)!)
        let SingleVarientValue = varients.first?.value as! Int
        
        var productVarient = ProductVarient()
        productVarient = (product?.strProductVarients[singleVarientsKey!])!
        // if cell.imgProduct.image == nil {
        let imgurl = product?.strProductimage.first?.value as! String
        let imgURL = URL(string: imgurl)
        
        cellProductItem.imgProduct.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        cellProductItem.imgProduct.layer.borderWidth = 1
        cellProductItem.imgProduct.layer.cornerRadius = 3
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imgURL!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cellProductItem.imgProduct.image = UIImage(data: data!)
            }
        }
        //}
        cellProductItem.ProBrand.text = product?.strProductbrand
        cellProductItem.ProTitle.text = product?.strProductName
        
        cellProductItem.ProLB.setTitle(productVarient.strUnit, for: .normal)
        cellProductItem.ProCount.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        cellProductItem.ProCount.layer.borderWidth = 1
        cellProductItem.ProCount.layer.cornerRadius = 4
        cellProductItem.ProCount.text = String(SingleVarientValue)
        let perProductTotalPrice = productVarient.strRegularPrice! * Float(SingleVarientValue)
        cellProductItem.ProPrice .text = String(productVarient.strRegularPrice!)
        cellProductItem.ProTotalPrice.text = String(perProductTotalPrice)

        return cellProductItem
    } else if indexPath.section == 5 {
        let fee = deliveryfeeArr["fee"] as! Float
        let to = deliveryfeeArr["to"] as! Float
        if totalCheckOutPrice >= to {
            cellMore.deliveryFeeview.isHidden = true
            cellMore.btnAddMoreProduct.isHidden = true
        }else {
            cellMore.deliveryFeeview.isHidden = false
            cellMore.deliveryFee.text = "-$ \(fee) "
            cellMore.btnAddMoreProduct.addTarget(self, action: #selector(addMoreProduct), for: .touchUpInside)
        }
        return cellMore
    }else if indexPath.section == 6 {
        cellPlaceOrder.orderTotalAmount.text = String(totalCheckOutPrice)
        cellPlaceOrder.btnCreditcard.addTarget(self, action: #selector(placeOrder), for: .touchUpInside)
        return cellPlaceOrder
    }
    return AddressListTableViewCell()
    }
}

