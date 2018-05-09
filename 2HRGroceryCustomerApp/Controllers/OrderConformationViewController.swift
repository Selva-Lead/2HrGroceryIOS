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
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ThankyouViewController") as! ThankyouViewController
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
        
        return 1
    }
    

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellName") as! AddressListTableViewCell
    let celldetail = tableView.dequeueReusableCell(withIdentifier: "cellAddress") as! AddressListTableViewCell
    let cellPaymentDate = tableView.dequeueReusableCell(withIdentifier: "cellPaymentDate") as! AddressListTableViewCell
    let cellCard = tableView.dequeueReusableCell(withIdentifier: "cellCard") as! AddressListTableViewCell
    let cellProductItem = tableView.dequeueReusableCell(withIdentifier: "cellProductDetails") as! AddressListTableViewCell
    let cellMore = tableView.dequeueReusableCell(withIdentifier: "cellMoreProduct") as! AddressListTableViewCell
    let cellPlaceOrder = tableView.dequeueReusableCell(withIdentifier: "cellPlaceOrder") as! AddressListTableViewCell
    
    if indexPath.section == 0 {
        cell.addrName.text = "name from Firebase"
        return cell
    }else if indexPath.section == 1 {
        celldetail.lbladdrDetail.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        celldetail.lbladdrDetail.layer.borderWidth = 1.0
        celldetail.lbladdrDetail.text = "erteuwyfeuwif \n eifrewfds \n  frwefnsv \n isfre rfnsvfd vorfvnfgh afhnvdfghfvfrjryrrlcj"
        return celldetail
    }else if indexPath.section == 2 {
        //cellDateAndTime.
        //cellPaymentDate.vewDateAndTime.layer.borderWidth = 1.0
        //cellPaymentDate.vewDateAndTime.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
        return cellPaymentDate
    } else if indexPath.section == 3 {
        return cellCard
    } else if indexPath.section == 4 {
        return cellProductItem
    } else if indexPath.section == 5 {
        return cellMore
    }else if indexPath.section == 6 {
        cellPlaceOrder.btnCreditcard.addTarget(self, action: #selector(placeOrder), for: .touchUpInside)
        return cellPlaceOrder
    }
    return AddressListTableViewCell()
    }
}

