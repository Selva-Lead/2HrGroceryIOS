//
//  FacebookAuthenController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 03/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class FacebookAuthenController: UIViewController {

    var appDelegate = AppDelegate()
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var nextbtn: UIButton!
    var Details: DatabaseReference!
    var FirstName: String!
    var LastName: String!
    var Email: String!
    var Photo: String!
    
    override func viewWillAppear(_ animated: Bool)
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        self.Details = Database.database().reference().child("Customer-List")
        print(useruidstatus)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.navigationItem.setHidesBackButton(true, animated:true);
       
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            topview.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            topview.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            topview.layer.shadowOpacity = 1.0
            topview.layer.shadowRadius = 10.0
            
            self.nextbtn.layer.cornerRadius = 12
            self.nextbtn.clipsToBounds = true
        }
        else
        {
            topview.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            topview.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            topview.layer.shadowOpacity = 1.0
            topview.layer.shadowRadius = 20.0
            
            self.nextbtn.layer.cornerRadius = 24
            self.nextbtn.clipsToBounds = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextAction(_ sender: Any)
    {
        if useruidstatus == "Exsist"
        {
            for controller in self.navigationController!.viewControllers as Array
            {
                if controller.isKind(of: HomeViewController.self)
                {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        }
        else
        {
            print(useruid!)
            let customerdetails = ["userId":useruid,
                                   "firstName": FirstName as String,
                                   "lastName": LastName as String,
                                   "email": Email,
                                   "profilePic": Photo]
            self.Details.child(useruid!).setValue(customerdetails)
            
            for controller in self.navigationController!.viewControllers as Array
            {
                if controller.isKind(of: HomeViewController.self)
                {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
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
