//
//  EmailForgotController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 03/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class EmailForgotController: UIViewController {

    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var continuebtn: UIButton!
    @IBOutlet weak var forgottopview: UIView!

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
            forgottopview.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            forgottopview.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            forgottopview.layer.shadowOpacity = 1.0
            forgottopview.layer.shadowRadius = 10.0
            
            EmailTF.layer.borderWidth = 0.5
            EmailTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            let usernamepadding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.EmailTF.frame.height))
            EmailTF.leftView = usernamepadding
            EmailTF.leftViewMode = UITextFieldViewMode.always
            EmailTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            EmailTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            EmailTF.layer.shadowOpacity = 1.0
            EmailTF.layer.shadowRadius = 4.0
            EmailTF.layer.cornerRadius = 12.0
            
            self.continuebtn.layer.cornerRadius = 12
            self.continuebtn.clipsToBounds = true
        }
        else
        {
            forgottopview.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            forgottopview.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            forgottopview.layer.shadowOpacity = 1.0
            forgottopview.layer.shadowRadius = 20.0
            
            EmailTF.layer.borderWidth = 1
            EmailTF.layer.borderColor = UIColor.lightGray.cgColor
            let usernamepadding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.EmailTF.frame.height))
            EmailTF.leftView = usernamepadding
            EmailTF.leftViewMode = UITextFieldViewMode.always
            EmailTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            EmailTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            EmailTF.layer.shadowOpacity = 1.0
            EmailTF.layer.shadowRadius = 8.0
            
            self.continuebtn.layer.cornerRadius = 24
            self.continuebtn.clipsToBounds = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func popvc(sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func ForgotAction(_ sender: Any)
    {
        if self.EmailTF.text == ""
        {
            let alertController = UIAlertController(title: "Alert", message: "Please Enter an Email.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else
        {
            Auth.auth().sendPasswordReset(withEmail: self.EmailTF.text!, completion: { (error) in
                
                if error != nil
                {
                    let alertController = UIAlertController(title: "Alert", message: (error?.localizedDescription)!, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                else
                {
                    self.EmailTF.text = ""
                  
                    let alert = UIAlertController(title: "Alert", message: "Password reset email sent.", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            })
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
