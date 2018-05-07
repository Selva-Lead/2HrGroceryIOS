//
//  DeliveryDateTimeViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 04/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class DeliveryDateTimeViewController: UIViewController {


    struct addressList {
        struct name {
            static let identifier = "cellName"
        }
        struct address {
            static let identifier = "cellAddress"
        }
        struct dateAndTime {
            static let identifier = "cellDateAndTime"
        }
    }
        
    
     @ IBOutlet weak var deliTopView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        deliTopView.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        deliTopView.layer.borderWidth = 0.5
        deliTopView.layer.shadowColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        deliTopView.layer.shadowOffset = CGSize(width: 1, height: 2.0)
        deliTopView.layer.shadowOpacity = 1.0
        deliTopView.layer.shadowRadius = 10.0

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ContinuePayment(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DeliveryOptionsViewController") as! DeliveryOptionsViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DeliveryDateTimeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "CUSTOMER NAME"
        } else if section == 1 {
            return "DELIVERY ADDRESS"
        } else  {
            return "Delivery Date & Time"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if section == 2 {
            return 7
        }
        return 1
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 72
        }else if indexPath.section == 1 {
            return 121
        }else {
            return 37
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: addressList
            .name.identifier) as! AddressListTableViewCell
        let celldetail = tableView.dequeueReusableCell(withIdentifier: addressList.address.identifier) as! AddressListTableViewCell
        let cellDateAndTime = tableView.dequeueReusableCell(withIdentifier: addressList.dateAndTime.identifier) as! AddressListTableViewCell

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
            cellDateAndTime.vewDateAndTime.layer.borderWidth = 1.0
            cellDateAndTime.vewDateAndTime.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            return cellDateAndTime
        }
        return AddressListTableViewCell()
    }
    
    
}
