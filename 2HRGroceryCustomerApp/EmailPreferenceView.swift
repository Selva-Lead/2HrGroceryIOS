//
//  EmailPreferenceView.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 02/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class EmailPreferenceView: UIViewController {

    @IBOutlet weak var continuebtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var preferenceview: UIView!
    @IBOutlet weak var smsbtn: UIButton!
    @IBOutlet weak var emailbtn: UIButton!
    var emaildate :String!
    var emailtime :String!
    var smsdate :String!
    var smstime :String!
    var Preference: DatabaseReference!
    var appDelegate = AppDelegate()

    override func viewWillAppear(_ animated: Bool) {
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        emailpreference = "NO"
        smspreference = "NO"
        
        if emailpreference == "NO"
        {
            emailbtn.setImage(UIImage(named: "uncheck.png"), for: .normal)
        }
        else if smspreference == "NO"
        {
           smsbtn.setImage(UIImage(named: "uncheck.png"), for: .normal)
        }

        emailTF.text = UserEmailID
        self.preferencedata()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.setHidesBackButton(true, animated:true);

        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        Preference = Database.database().reference().child("Customer-List").child(useruid)

        if UIDevice.current.userInterfaceIdiom == .phone
        {
            preferenceview.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            preferenceview.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            preferenceview.layer.shadowOpacity = 1.0
            preferenceview.layer.shadowRadius = 10.0
            
            emailTF.layer.borderWidth = 1
            emailTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            let addpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.emailTF.frame.height))
            emailTF.leftView = addpaddingView
            emailTF.leftViewMode = UITextFieldViewMode.always
            emailTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            emailTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            emailTF.layer.shadowOpacity = 1.0
            emailTF.layer.shadowRadius = 4.0
            
            mobileTF.layer.borderWidth = 1
            mobileTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.mobileTF.frame.height))
            mobileTF.leftView = paddingView
            mobileTF.leftViewMode = UITextFieldViewMode.always
            mobileTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            mobileTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            mobileTF.layer.shadowOpacity = 1.0
            mobileTF.layer.shadowRadius = 4.0
            
            self.continuebtn.layer.cornerRadius = 10
            self.continuebtn.clipsToBounds = true
        }
        else
        {
            preferenceview.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            preferenceview.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            preferenceview.layer.shadowOpacity = 1.0
            preferenceview.layer.shadowRadius = 20.0
            
            emailTF.layer.borderWidth = 1
            emailTF.layer.borderColor = UIColor.lightGray.cgColor
            let addpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.emailTF.frame.height))
            emailTF.leftView = addpaddingView
            emailTF.leftViewMode = UITextFieldViewMode.always
            emailTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            emailTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            emailTF.layer.shadowOpacity = 1.0
            emailTF.layer.shadowRadius = 8.0
            
            mobileTF.layer.borderWidth = 1
            mobileTF.layer.borderColor = UIColor.lightGray.cgColor
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.mobileTF.frame.height))
            mobileTF.leftView = paddingView
            mobileTF.leftViewMode = UITextFieldViewMode.always
            mobileTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            mobileTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            mobileTF.layer.shadowOpacity = 1.0
            mobileTF.layer.shadowRadius = 8.0
            
            self.continuebtn.layer.cornerRadius = 20
            self.continuebtn.clipsToBounds = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func smsActn(_ sender: Any)
    {
        let datetime = Date()
        let datetimeformatter = DateFormatter()
        datetimeformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateandtime = datetimeformatter.string(from: datetime)
        print(dateandtime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        let date = dateFormatter.date(from: dateandtime)!
        dateFormatter.dateFormat = "dd/MM/yyyy" //Your New Date format as per requirement change it own
        let newDate = dateFormatter.string(from: date)
        print(newDate)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        timeFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        let time = timeFormatter.date(from: dateandtime)!
        timeFormatter.dateFormat = "hh:mm a" //Your New Time format as per requirement change it own
        let newTime = timeFormatter.string(from: time)
        print(newTime)
        
        if smspreference == "NO"
        {
            smsbtn.setImage(UIImage(named: "check.png"), for: .normal)
            smspreference = "YES"
        }
        else
        {
            smsbtn.setImage(UIImage(named: "uncheck.png"), for: .normal)
            smspreference = "NO"
        }
    }
    
    @IBAction func emailActn(_ sender: Any)
    {
        if emailpreference == "NO"
        {
            emailbtn.setImage(UIImage(named: "check.png"), for: .normal)
            emailpreference = "YES"
        }
        else
        {
            emailbtn.setImage(UIImage(named: "uncheck.png"), for: .normal)
            emailpreference = "NO"
        }
    }
    
    @IBAction func ContinueAction(_ sender: Any)
    {
        if self.mobileTF.text == ""
        {
            let alertController = UIAlertController(title: "Alert", message: "Please Mobile Number", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)

        }
        else
        {
            let datetime = Date()
            let datetimeformatter = DateFormatter()
            datetimeformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let dateandtime = datetimeformatter.string(from: datetime)
            print(dateandtime)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
            let date = dateFormatter.date(from: dateandtime)!
            dateFormatter.dateFormat = "dd/MM/yyyy" //Your New Date format as per requirement change it own
            let newDate = dateFormatter.string(from: date)
            print(newDate)
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            timeFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
            let time = timeFormatter.date(from: dateandtime)!
            timeFormatter.dateFormat = "hh:mm a" //Your New Time format as per requirement change it own
            let newTime = timeFormatter.string(from: time)
            print(newTime)
            
            if emailpreference == "YES" && smspreference == "YES"
            {
                let emailpreference = ["allow":"true",
                                       "allowed": "true",
                                       "consent-date": newDate,
                                       "consent-time": newTime,
                                       "time": dateandtime
                ]
                let smspreference = ["allow":"true",
                                     "allowed": "true",
                                     "consent-date": newDate,
                                     "consent-time": newTime,
                                     "time": dateandtime
                ]
                
                self.Preference.child("consent").child("email").updateChildValues(emailpreference)
                self.Preference.child("consent").child("SMS").updateChildValues(smspreference)
            }
            else if emailpreference == "NO" && smspreference == "YES"
            {
                let emailpreference = ["allow":"false",
                                       "allowed": "false",
                                       "consent-date": newDate,
                                       "consent-time": newTime,
                                       "time": dateandtime
                ]
                let smspreference = ["allow":"true",
                                     "allowed": "true",
                                     "consent-date": newDate,
                                     "consent-time": newTime,
                                     "time": dateandtime
                ]
                
                self.Preference.child("consent").child("email").updateChildValues(emailpreference)
                self.Preference.child("consent").child("SMS").updateChildValues(smspreference)
            }
            else if emailpreference == "YES" && smspreference == "NO"
            {
                let emailpreference = ["allow":"true",
                                       "allowed": "true",
                                       "consent-date": newDate,
                                       "consent-time": newTime,
                                       "time": dateandtime
                ]
                let smspreference = ["allow":"false",
                                     "allowed": "false",
                                     "consent-date": newDate,
                                     "consent-time": newTime,
                                     "time": dateandtime
                ]
                
                self.Preference.child("consent").child("email").updateChildValues(emailpreference)
                self.Preference.child("consent").child("SMS").updateChildValues(smspreference)
            }
            else if emailpreference == "NO" && smspreference == "NO"
            {
                let emailpreference = ["allow":"false",
                                       "allowed": "false",
                                       "consent-date": newDate,
                                       "consent-time": newTime,
                                       "time": dateandtime
                ]
                let smspreference = ["allow":"false",
                                     "allowed": "false",
                                     "consent-date": newDate,
                                     "consent-time": newTime,
                                     "time": dateandtime
                ]
                
                self.Preference.child("consent").child("email").updateChildValues(emailpreference)
                self.Preference.child("consent").child("SMS").updateChildValues(smspreference)
            }
            
            let phone = ["phone":mobileTF.text!]
            self.Preference.updateChildValues(phone)
            let userdefault = UserDefaults.standard
            userdefault.set(mobileTF.text!, forKey: "phone")
            userdefault.synchronize()
            
            
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
    
    func preferencedata()
    {
        let datetime = Date()
        let datetimeformatter = DateFormatter()
        datetimeformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateandtime = datetimeformatter.string(from: datetime)
        print(dateandtime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        let date = dateFormatter.date(from: dateandtime)!
        dateFormatter.dateFormat = "dd/MM/yyyy" //Your New Date format as per requirement change it own
        let newDate = dateFormatter.string(from: date)
        print(newDate)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        timeFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        let time = timeFormatter.date(from: dateandtime)!
        timeFormatter.dateFormat = "hh:mm a" //Your New Time format as per requirement change it own
        let newTime = timeFormatter.string(from: time)
        print(newTime)
                
        Preference = Database.database().reference().child("Customer-List").child(useruid)
      
        Preference.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.hasChild("consent")
            {
                print("consent exsist")
            }
            else
            {
                let customerdetails = ["allow":"false",
                                       "allowed": "false",
                                       "consent-date": newDate,
                                       "consent-time": newTime,
                                       "time": dateandtime
                ]
                
                self.Preference.child("consent").child("SMS").setValue(customerdetails)
                self.Preference.child("consent").child("email").setValue(customerdetails)
            }
        })
        
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
