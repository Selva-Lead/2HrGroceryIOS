//
//  ThankyouViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 08/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class ThankyouViewController: UIViewController {
 @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        topView.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        topView.layer.borderWidth = 0.5
        topView.layer.shadowColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        topView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        topView.layer.shadowOpacity = 1.0
        topView.layer.shadowRadius = 5.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func continueShipping(_ sender: Any) {
        
        for controller in self.navigationController!.viewControllers as Array
        {
            if controller.isKind(of: UserHomeViewController.self)
            {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
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
