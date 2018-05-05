//
//  ViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 30/04/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var FirstnameTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var LastnameTF: UITextField!
    @IBOutlet weak var ContinueBtn: UIButton!
    var Customer: DatabaseReference!
    var appDelegate = AppDelegate()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate

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
            
            let FirstView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.FirstnameTF.frame.height))
            FirstnameTF.layer.borderWidth = 1
            FirstnameTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            FirstnameTF.leftView = FirstView
            FirstnameTF.leftViewMode = UITextFieldViewMode.always
            FirstnameTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            FirstnameTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            FirstnameTF.layer.shadowOpacity = 1.0
            FirstnameTF.layer.shadowRadius = 4.0
            
            let PasswordView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.PasswordTF.frame.height))
            PasswordTF.layer.borderWidth = 1
            PasswordTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            PasswordTF.leftView = PasswordView
            PasswordTF.leftViewMode = UITextFieldViewMode.always
            PasswordTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            PasswordTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            PasswordTF.layer.shadowOpacity = 1.0
            PasswordTF.layer.shadowRadius = 4.0
            
            let EmailView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.EmailTF.frame.height))
            EmailTF.layer.borderWidth = 1
            EmailTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            EmailTF.leftView = EmailView
            EmailTF.leftViewMode = UITextFieldViewMode.always
            EmailTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            EmailTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            EmailTF.layer.shadowOpacity = 1.0
            EmailTF.layer.shadowRadius = 4.0
            
            let LastView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.LastnameTF.frame.height))
            LastnameTF.layer.borderWidth = 1
            LastnameTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            LastnameTF.leftView = LastView
            LastnameTF.leftViewMode = UITextFieldViewMode.always
            LastnameTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            LastnameTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            LastnameTF.layer.shadowOpacity = 1.0
            LastnameTF.layer.shadowRadius = 4.0
        }
        else
        {
            topview.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            topview.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            topview.layer.shadowOpacity = 1.0
            topview.layer.shadowRadius = 20.0
            
            let FirstView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.FirstnameTF.frame.height))
            FirstnameTF.layer.borderWidth = 2
            FirstnameTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            FirstnameTF.leftView = FirstView
            FirstnameTF.leftViewMode = UITextFieldViewMode.always
            FirstnameTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            FirstnameTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            FirstnameTF.layer.shadowOpacity = 1.0
            FirstnameTF.layer.shadowRadius = 8.0
            
            let PasswordView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.PasswordTF.frame.height))
            PasswordTF.layer.borderWidth = 2
            PasswordTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            PasswordTF.leftView = PasswordView
            PasswordTF.leftViewMode = UITextFieldViewMode.always
            PasswordTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            PasswordTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            PasswordTF.layer.shadowOpacity = 1.0
            PasswordTF.layer.shadowRadius = 8.0
            
            let EmailView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.EmailTF.frame.height))
            EmailTF.layer.borderWidth = 2
            EmailTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            EmailTF.leftView = EmailView
            EmailTF.leftViewMode = UITextFieldViewMode.always
            EmailTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            EmailTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            EmailTF.layer.shadowOpacity = 1.0
            EmailTF.layer.shadowRadius = 8.0
            
            let LastView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.LastnameTF.frame.height))
            LastnameTF.layer.borderWidth = 2
            LastnameTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            LastnameTF.leftView = LastView
            LastnameTF.leftViewMode = UITextFieldViewMode.always
            LastnameTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            LastnameTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            LastnameTF.layer.shadowOpacity = 1.0
            LastnameTF.layer.shadowRadius = 8.0
        }
        
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            ContinueBtn.layer.cornerRadius = 10
            ContinueBtn.clipsToBounds = true
        }
        else
        {
            ContinueBtn.layer.cornerRadius = 20
            ContinueBtn.clipsToBounds = true
        }
        
        Customer = Database.database().reference().child("Customer-List");

    }
    
    @objc func popvc(sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CreateActn(_ sender: Any)
    {
        if FirstnameTF.text == ""
        {
            let alertController = UIAlertController(title: "Alert", message: "Please Enter First Name", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else if LastnameTF.text == ""
        {
            let alertController = UIAlertController(title: "Alert", message: "Please Enter Last Name", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else if EmailTF.text == ""
        {
            let alertController = UIAlertController(title: "Alert", message: "Please Enter Email Address", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else if PasswordTF.text == ""
        {
            let alertController = UIAlertController(title: "Alert", message: "Please Enter Password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else
        {
            Auth.auth().createUser(withEmail: EmailTF.text!, password: PasswordTF.text!) { (user, error) in
                
                if error == nil
                {
                    print("You have successfully signed up")
                    print(user!.uid)
                    
                   // let key = self.Customer.childByAutoId().key
                  //  let key = self.Customer.child(user!.uid)
                    
                    //creating artist with the given values
                    let customerdetails = ["userId":user!.uid as String,
                                           "firstName": self.FirstnameTF.text! as String,
                                  "lastName": self.LastnameTF.text! as String,
                                  "email": self.EmailTF.text! as String
                    ]
                    
                    useruid = user!.uid
                    UserEmailID = self.EmailTF.text!
                    //adding the artist inside the generated unique key
                    self.Customer.child(user!.uid).setValue(customerdetails)
                    
                    let userdefault = UserDefaults.standard
                    userdefault.set(self.FirstnameTF.text!, forKey: "firstName")
                    userdefault.set(self.LastnameTF.text!, forKey: "lastName")
                    userdefault.set(self.EmailTF.text!, forKey: "email")
                    userdefault.set(useruid, forKey: "uid")
                    userdefault.synchronize()

                    
                    if UIDevice.current.userInterfaceIdiom == .phone
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DeliveryViewController") as! DeliveryaddressViewController
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    else
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "ipad", bundle:nil)
                        
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DeliveryViewController") as! DeliveryaddressViewController
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    //let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    //self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    

}

