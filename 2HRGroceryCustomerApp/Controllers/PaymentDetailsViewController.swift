//
//  PaymentDetailsViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 05/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import Stripe


class PaymentDetailsViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var payTopView: UIView!
    var pickupAddress :String?
    var strfull :String?
    override func viewDidLoad() {
        super.viewDidLoad()
       // let nib = UINib(nibName: "PaymentHeader", bundle: Bundle.main)
        let nib = UINib(nibName: "View", bundle: nil)
        self.tblView.register(nib, forHeaderFooterViewReuseIdentifier: "PaymentHeader")
        //self.tableView.register(nib, forHeaderFooterViewReuseIdentifier: "PaymentHeader")
        payTopView.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        payTopView.layer.borderWidth = 0.5
        payTopView.layer.shadowColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        payTopView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        payTopView.layer.shadowOpacity = 1.0
        payTopView.layer.shadowRadius = 10.0
        // Do any additional setup after loading the view.
        if deliveryOption == 2 {
            pickupAddressAndTime()
        }
    }
    func pickupAddressAndTime() {
        let pickAddress: [String:AnyObject] = storeSettingarr["storePickupAddress"] as! [String:AnyObject]
        print(pickAddress)
        let state = pickAddress["state"] as! String
        let city = pickAddress["city"] as! String
        let addressLine1 = pickAddress["addressLine1"] as! String
        let zipCode = pickAddress["zipcode"] as! Int
        let add1 = addressLine1.appending("\n").appending(city)
        let add2 = add1.appending("\n").appending(state)
        pickupAddress = add2.appending("\n").appending(String(zipCode))
        let pickuptime :[String:AnyObject] = storeSettingarr["storeTime"] as! [String:AnyObject]
        let PickstartTime = pickuptime["openTime"] as! String
        let pStart = PickstartTime.split(separator: ":")
        let pstartVa = Int(pStart[0])
        let PickStartDteinNormalTime =  normalTimeArr[pstartVa!]
        let PickEndTime = pickuptime["closingTime"] as! String
        let pEnd = PickEndTime.split(separator: ":")
        let pEndVa = Int(pEnd[0])
        let PickEndDteinNormalTime =  normalTimeArr[pEndVa!]
        let now = Date()
        //nowComponents.year = Calendar.current.component(.year, from: now!)
        let month = Calendar.current.component(.month, from: now)
        let day = Calendar.current.component(.day, from: now)
        let iweekday = Calendar.current.component(.weekday, from: now)
        let Weekday = getWeekday(weekday: iweekday)
        let str = "-"
        strfull = "\(month)/\(day) \(Weekday) \(PickStartDteinNormalTime) \(str) \(PickEndDteinNormalTime)"
        
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
    @objc func PaymentCreditCard(_ sender: Any) {
        if savedCards.count != 0  {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentWithCardDetailViewController") as! PaymentWithCardDetailViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }else {
            handleAddPaymentMethodButtonTapped()
        }
      
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreditCardViewController") as! CreditCardViewController
//        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    func handleAddPaymentMethodButtonTapped() {
        // Setup add card view controller
        let addCardViewController = STPAddCardViewController()
        addCardViewController.delegate = self
        // Present add card view controller
        let navigationController = UINavigationController(rootViewController: addCardViewController)
        present(navigationController, animated: true)
    }
   
    
    // MARK: STPAddCardViewControllerDelegate
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        // Dismiss add card view controller
        dismiss(animated: true)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        submitTokenToBack(token: token, completion: {(error) in
            if  error  == nil{
                // Show error in add card view controller
                completion(error)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentWithCardDetailViewController") as! PaymentWithCardDetailViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            else {
                // Notify add card view controller that token creation was handled successfully
                completion(error)
                // Dismiss add card view controller
            }
        })
    }
    func submitTokenToBack(token : STPToken, completion: @escaping (_ Error:NSError?) -> ())   {
        self.dismiss(animated: true)
        let tokenValue = token.allResponseFields
        print("token value \(token.allResponseFields) and \(tokenValue)")
        let tempSaveCard = saveCard()
         let tokenval = tokenValue as? [String: Any]
        if let cardValues = tokenval!["card"] as? [String:Any] {
            tempSaveCard.strBrand = (cardValues["brand"] as! String)
            tempSaveCard.strExpMonth = (cardValues["exp_month"] as! Int)
            tempSaveCard.strExpYear = (cardValues["exp_year"] as! Int)
            tempSaveCard.strLastFour = (cardValues["last4"] as! String)
        }
        FireAuthModel().saveCards(CustomerId: useruid, Token: token.stripeID,valueSaveCard: tempSaveCard){ error in
            if error != nil {
                completion(error as NSError?)
            }else {
                completion (nil)
            }
        }
    }
    
    @objc func addressChange(sender: UIButton) {
        
    }
    @objc func dataAndTimeChange(sender: UIButton) {
        
    }
}
extension PaymentDetailsViewController: STPAddCardViewControllerDelegate {
    
}

extension PaymentDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
         return 4
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PaymentHeader") as! PaymentHeader
        if section == 0  {
            cell.btnChange.isHidden = true
            cell.lblTitle.text = "CUSTOMER NAME"
        }else if section == 1 {
            if deliveryOption == 1 {
                cell.btnChange.isHidden = false
            }else {
                cell.btnChange.isHidden = true
            }
           // cell.btnChange.isHidden = false
            cell.btnChange.tag = section
            cell.lblTitle.text = "DELIVERY ADDRESS"
            cell.btnChange.addTarget(self, action: #selector(addressChange(sender:)), for: .touchUpInside)
        }else if section == 2 {
            if deliveryOption == 1 {
                cell.btnChange.isHidden = false
            }else {
                cell.btnChange.isHidden = true
            }
            //cell.btnChange.isHidden = false
            cell.btnChange.tag = section
            cell.btnChange.addTarget(self, action: #selector(dataAndTimeChange(sender:)), for:.touchUpInside)
             cell.lblTitle.text = "DELIVERY DATE& TIME"
        }else if section == 3 {
            cell.btnChange.isHidden = true
            cell.lblTitle.text = "PAYMENT METHOD"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.isScrollEnabled = false
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellName") as! AddressListTableViewCell
        let celldetail = tableView.dequeueReusableCell(withIdentifier: "cellAddress") as! AddressListTableViewCell
        let cellPaymentDateAndTime = tableView.dequeueReusableCell(withIdentifier: "cellPaymentDate") as! AddressListTableViewCell
        let cellPayment = tableView.dequeueReusableCell(withIdentifier: "cellPayment") as! AddressListTableViewCell
        cell.selectionStyle = .none
        celldetail.selectionStyle = .none
        cellPaymentDateAndTime.selectionStyle = .none
        cellPayment.selectionStyle = .none
        if indexPath.section == 0 {
            cell.addrName.text = UserDisplayName
            return cell
        }else if indexPath.section == 1 {
            celldetail.lbladdrDetail.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
            celldetail.lbladdrDetail.layer.borderWidth = 1.0
            if deliveryOption == 1 {
                celldetail.lbladdrDetail.text = customAddressList[0].strFullAddress
            }else {
               celldetail.lbladdrDetail.text = pickupAddress
            }
            return celldetail
        }else if indexPath.section == 2 {
            let selectedDate = selectedDateandTime //UserDefaults.standard.object(forKey: "DeliveryDateAndTime") as! String
            if deliveryOption == 1 {
                cellPaymentDateAndTime.txtPaymentDate.text = selectedDate
            }else {
                cellPaymentDateAndTime.txtPaymentDate.text = strfull
            }
            return cellPaymentDateAndTime
        }else if indexPath.section == 3 {
            cellPayment.btnCreditcard.addTarget(self, action: #selector(PaymentCreditCard(_:)), for: .touchUpInside)
            return cellPayment
        }
        return AddressListTableViewCell()
    }
    
    
}
