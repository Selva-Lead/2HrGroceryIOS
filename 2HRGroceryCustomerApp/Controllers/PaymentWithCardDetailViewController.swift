//
//  PaymentWithCardDetailViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 08/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class PaymentWithCardDetailViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "View", bundle: nil)
        self.tblView.register(nib, forHeaderFooterViewReuseIdentifier: "PaymentHeader")
       
        topView.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        topView.layer.borderWidth = 0.5
        topView.layer.shadowColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        topView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        topView.layer.shadowOpacity = 1.0
        topView.layer.shadowRadius = 10.0
        // Do any additional setup after loading the view.
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
    @objc func processCompletion() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OrderConformationViewController") as! OrderConformationViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
extension PaymentWithCardDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        //if section == 4 {
            return 0
        //}
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PaymentHeader") as! PaymentHeader
        if section == 0  {
            cell.btnChange.isHidden = true
            cell.lblTitle.text = "CUSTOMER NAME"
        }else if section == 1 {
            cell.btnChange.isHidden = false
            cell.lblTitle.text = "DELIVERY ADDRESS"
        }else if section == 2 {
            cell.btnChange.isHidden = false
            cell.lblTitle.text = "DELIVERY DATE& TIME"
        }else if section == 3 {
            cell.btnChange.isHidden = true
            cell.lblTitle.text = "PAYMENT METHOD"
        }else if section == 4  {
            cell.removeFromSuperview()
            cell.isHidden = true
            //cell.backgroundColor = UIColor.blue
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 4
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellName") as! AddressListTableViewCell
        let celldetail = tableView.dequeueReusableCell(withIdentifier: "cellAddress") as! AddressListTableViewCell
        let cellPaymentDateAndTime = tableView.dequeueReusableCell(withIdentifier: "cellPaymentDate") as! AddressListTableViewCell
        let cellCardSelection = tableView.dequeueReusableCell(withIdentifier: "cellCardSelection") as! AddressListTableViewCell
        let cellComplete = tableView.dequeueReusableCell(withIdentifier: "cellComplete") as! AddressListTableViewCell
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
            //            cellDateAndTime.vewDateAndTime.layer.borderWidth = 1.0
            //            cellDateAndTime.vewDateAndTime.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            cellPaymentDateAndTime.txtPaymentDate.text = "3/20 FRIDAY 10:00am - 12:00 pm"
            return cellPaymentDateAndTime
        }else if indexPath.section == 3 {
            if indexPath.row <= 2 {
                cellCardSelection.ExistingCardView.isHidden = false
                cellCardSelection.addCardView.isHidden = true
            }else {
                cellCardSelection.ExistingCardView.isHidden = true
                cellCardSelection.addCardView.isHidden = false
            }
         
            return cellCardSelection
        } else if indexPath.section == 4 {
            cellComplete.btnProcessComplete.addTarget(self, action: #selector(processCompletion), for: .touchUpInside)
            return cellComplete
        }
        return AddressListTableViewCell()
    }
    
    
}
