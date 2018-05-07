//
//  CreditCardViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 05/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import Stripe

class CreditCardViewController: UIViewController {
    
    @IBOutlet weak var btnCardSave: UIButton!
    let paymentCardTextField = STPPaymentCardTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  paymentCardTextField.delegate = self
      //  view.addSubview(paymentCardTextField)
        // Do any additional setup after loading the view.
    }
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        // Toggle buy button state
//        //btnCardSave.isEnabled = textField.isValid
//        let stCard = STPCar
////        if self.expireDateTextField.text.isEmpty == false {
////            let expirationDate = self.expireDateTextField.text.componentsSeparatedByString("/")
////            let expMonth = UInt(expirationDate[0].toInt()!)
////            let expYear = UInt(expirationDate[1].toInt()!)
////
//            // Send the card info to Strip to get the token
//            stripCard.number = "4242 42424 24242 4242"
//            stripCard.cvc = "123"
//            stripCard.expMonth = "10"
//            stripCard.expYear = "20"
        //}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CardUsingFunction(_ sender: Any) {
        let textField : STPPaymentCardTextField
        //textField = "4545454545454544545 02/05 789"
       // paymentCardTextFieldDidChange(textField)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OrderConformationViewController") as! OrderConformationViewController
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
extension CreditCardViewController: STPPaymentCardTextFieldDelegate {
    
}
