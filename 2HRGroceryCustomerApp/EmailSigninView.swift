//
//  EmailSigninView.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 03/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class EmailSigninView: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var continuebtn: UIButton!
    @IBOutlet weak var topview: UIView!
    var UserDetails: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back.png"), for: .normal)
        backbutton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backbutton.addTarget(self, action: #selector(popvc), for: .touchUpInside)
        let backbuttonitem = UIBarButtonItem(customView: backbutton)
        self.navigationItem.leftBarButtonItem = backbuttonitem
        
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            topview.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            topview.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            topview.layer.shadowOpacity = 1.0
            topview.layer.shadowRadius = 10.0
            
            usernameTF.layer.borderWidth = 0.5
            usernameTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            let usernamepadding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.usernameTF.frame.height))
            usernameTF.leftView = usernamepadding
            usernameTF.leftViewMode = UITextFieldViewMode.always
            usernameTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            usernameTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            usernameTF.layer.shadowOpacity = 1.0
            usernameTF.layer.shadowRadius = 4.0
            usernameTF.layer.cornerRadius = 12.0
            
            passwordTF.layer.borderWidth = 0.5
            passwordTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            let passwordpadding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.passwordTF.frame.height))
            passwordTF.leftView = passwordpadding
            passwordTF.leftViewMode = UITextFieldViewMode.always
            passwordTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            passwordTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            passwordTF.layer.shadowOpacity = 1.0
            passwordTF.layer.shadowRadius = 4.0
            passwordTF.layer.cornerRadius = 12.0

            self.continuebtn.layer.cornerRadius = 12
            self.continuebtn.clipsToBounds = true
        }
        else
        {
            topview.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            topview.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            topview.layer.shadowOpacity = 1.0
            topview.layer.shadowRadius = 20.0
            
            usernameTF.layer.borderWidth = 1
            usernameTF.layer.borderColor = UIColor.lightGray.cgColor
            let usernamepadding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.usernameTF.frame.height))
            usernameTF.leftView = usernamepadding
            usernameTF.leftViewMode = UITextFieldViewMode.always
            usernameTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            usernameTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            usernameTF.layer.shadowOpacity = 1.0
            usernameTF.layer.shadowRadius = 8.0
            usernameTF.layer.cornerRadius = 24.0
            
            passwordTF.layer.borderWidth = 1
            passwordTF.layer.borderColor = UIColor.lightGray.cgColor
            let passwordpadding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.passwordTF.frame.height))
            passwordTF.leftView = passwordpadding
            passwordTF.leftViewMode = UITextFieldViewMode.always
            passwordTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            passwordTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            passwordTF.layer.shadowOpacity = 1.0
            passwordTF.layer.shadowRadius = 8.0
            passwordTF.layer.cornerRadius = 24.0

            self.continuebtn.layer.cornerRadius = 24
            self.continuebtn.clipsToBounds = true
        }
        
    }

    @objc func popvc(sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SigninAction(_ sender: Any)
    {
        if usernameTF.text == ""
        {
            let alertController = UIAlertController(title: "Alert", message: "Please Enter Your Email", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else if passwordTF.text == ""
        {
            let alertController = UIAlertController(title: "Alert", message: "Please Enter Password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else
        {
            Auth.auth().signIn(withEmail: self.usernameTF.text!, password: self.passwordTF.text!) { (user, error) in
                
                if error == nil
                {
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    print(user?.uid as Any)
                    useruid = user!.uid
                 /*   self.UserDetails = Database.database().reference().child("Customer-List").child(useruid)

                    self.UserDetails.observe(.value, with: { snapshot in
                        
                        for item in snapshot.ch
                        {
                            //print(item)
                            let child = item as! DataSnapshot
                            print(child.value(forKey: "email")!)
                          //  let dict = child.value as! NSDictionary
                           // tempItems.append(item)
                        }
                    }) */
                    
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
                    let alertController = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
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
