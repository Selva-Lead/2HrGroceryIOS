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
       handleAddPaymentMethodButtonTapped()
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
            }
            else {
                // Notify add card view controller that token creation was handled successfully
                completion(nil)
                
                // Dismiss add card view controller
                dismiss(animated: true)
            }
        })
//        submitTokenToBackend(token, completion: { (error: Error?) in
//            if let error = error {
//                // Show error in add card view controller
//                completion(error)
//            }
//            else {
//                // Notify add card view controller that token creation was handled successfully
//                completion(nil)
//
//                // Dismiss add card view controller
//                dismiss(animated: true)
//            }
//        })
    }
    func submitTokenToBack(token : STPToken, completion: (_ Error:NSError?) -> ())   {
        let tokenValue = token.allResponseFields
        print("token value \(token.allResponseFields) and \(tokenValue)")
        
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
            cell.btnChange.isHidden = false
             cell.lblTitle.text = "DELIVERY ADDRESS"
        }else if section == 2 {
            cell.btnChange.isHidden = false
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
            cellPayment.btnCreditcard.addTarget(self, action: #selector(PaymentCreditCard(_:)), for: .touchUpInside)
            return cellPayment
        }
        return AddressListTableViewCell()
    }
    
    
}
