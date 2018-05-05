//
//  LoginViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 01/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var registerbtn: UIButton!
    @IBOutlet weak var emailbtn: UIButton!
    @IBOutlet weak var facebookbtn: UIButton!
    @IBOutlet weak var phonebtn: UIButton!
    var appDelegate = AppDelegate()
    var Checkuid: String!
    var Details: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate = UIApplication.shared.delegate as! AppDelegate

        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back.png"), for: .normal)
        backbutton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backbutton.addTarget(self, action: #selector(popvc), for: .touchUpInside)
        let backbuttonitem = UIBarButtonItem(customView: backbutton)
        self.navigationItem.leftBarButtonItem = backbuttonitem
        
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            registerbtn.layer.cornerRadius = 10
            registerbtn.clipsToBounds = true
            
            emailbtn.layer.cornerRadius = 10
            emailbtn.clipsToBounds = true
            
            facebookbtn.layer.cornerRadius = 10
            facebookbtn.clipsToBounds = true
            
            phonebtn.layer.cornerRadius = 10
            phonebtn.clipsToBounds = true
        }
        else
        {
            registerbtn.layer.cornerRadius = 20
            registerbtn.clipsToBounds = true
            
            emailbtn.layer.cornerRadius = 20
            emailbtn.clipsToBounds = true
            
            facebookbtn.layer.cornerRadius = 20
            facebookbtn.clipsToBounds = true
            
            phonebtn.layer.cornerRadius = 20
            phonebtn.clipsToBounds = true
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func popvc(sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func FacebookSigninAction(_ sender: Any)
    {
        var FirstName: String!
        var LastName: String!
        var Email: String!
        var Photo: String!
        
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            
            if let error = error
            {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                guard let uid = user?.uid else { return }
                print("Successfully logged into Firebase with facebook", uid)
                print("user name",user?.photoURL! as Any)
                print("user ",user?.displayName! as Any)
                print("user ",user?.email! as Any)
                print("user ",user?.uid as Any)
                
                var myString: String = user?.displayName! as! String
                var fullNameArr = myString.components(separatedBy: " ")
                FirstName = fullNameArr[0]
                LastName = fullNameArr[1]
                
                print(FirstName)
                print(LastName)
                
                Email = String(describing: user!.email!) as String
                Photo = String(describing: user!.photoURL!) as String

                useruid = user!.uid
                
                self.Details = Database.database().reference().child("Customer-List")
                
                self.Details.observe(DataEventType.value, with: { (snapshot) in
                    
                    if snapshot.hasChild(useruid)
                    {
                        print("Already Exsist")
                        useruidstatus = "Exsist"
                        
                        if UIDevice.current.userInterfaceIdiom == .phone
                        {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FacebookAuthenController") as! FacebookAuthenController
                            nextViewController.FirstName = FirstName
                            nextViewController.LastName = LastName
                            nextViewController.Email = Email
                            nextViewController.Photo = Photo
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                        else
                        {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "ipad", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DeliveryViewController") as! FacebookAuthenController
                            nextViewController.FirstName = FirstName
                            nextViewController.LastName = LastName
                            nextViewController.Email = Email
                            nextViewController.Photo = Photo
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                        
                        return
                    }
                    else
                    {
                        print("Not Exsist")
                        useruidstatus = "Not Exsist"
                        
                        if UIDevice.current.userInterfaceIdiom == .phone
                        {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FacebookAuthenController") as! FacebookAuthenController
                            nextViewController.FirstName = FirstName
                            nextViewController.LastName = LastName
                            nextViewController.Email = Email
                            nextViewController.Photo = Photo
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                        else
                        {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "ipad", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DeliveryViewController") as! FacebookAuthenController
                            nextViewController.FirstName = FirstName
                            nextViewController.LastName = LastName
                            nextViewController.Email = Email
                            nextViewController.Photo = Photo
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                        return
                    }
                })
        
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
