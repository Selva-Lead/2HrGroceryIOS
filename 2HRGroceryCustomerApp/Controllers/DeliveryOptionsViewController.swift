//
//  DeliveryOptionsViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 05/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

var normalTimeArr : [String] = ["12 AM",
                                       "1 AM",
                                       "2 AM",
                                       "3 AM",
                                       "4 AM",
                                       "5 AM",
                                       "6 AM",
                                       "7 AM",
                                       "8 AM",
                                       "9 AM",
                                       "10 AM",
                                       "11 AM",
                                       "12 PM",
                                        "1 PM",
                                        "2 PM",
                                        "3 PM",
                                        "4 PM",
                                        "5 PM",
                                        "6 PM",
                                        "7 PM",
                                        "8 PM",
                                        "9 PM",
                                        "10 PM",
                                        "11 PM"]
class DeliveryOptionsViewController: UIViewController {

    @IBOutlet weak var deliveryTop: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if useruid != ""
        {
            UserDisplayName = UserFirstName.appending(" \(UserLastName!)")
        }
        deliveryTop.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        deliveryTop.layer.borderWidth = 0.5
        deliveryTop.layer.shadowColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        deliveryTop.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        deliveryTop.layer.shadowOpacity = 1.0
        deliveryTop.layer.shadowRadius = 10.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func delivery(_ sender: UIButton) {
        deliveryOption = 1
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ConformDeliveryAddressViewController") as! ConformDeliveryAddressViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
    
    @IBAction func storePickup(_ sender: Any) {
        deliveryOption = 2
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
