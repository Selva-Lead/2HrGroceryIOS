//
//  ConformDeliveryAddressViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 16/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class ConformDeliveryAddressViewController: UIViewController {

    @IBOutlet weak var deliveryview: UIView!
    @IBOutlet weak var address2TF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var zipTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var continuebtn: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            deliveryview.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            deliveryview.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            deliveryview.layer.shadowOpacity = 1.0
            deliveryview.layer.shadowRadius = 10.0
            
            addressTF.layer.borderWidth = 1
            addressTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            addressTF.placeholder =  "Address Line 1"
            let addpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.addressTF.frame.height))
            addressTF.leftView = addpaddingView
            addressTF.leftViewMode = UITextFieldViewMode.always
            addressTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            addressTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            addressTF.layer.shadowOpacity = 1.0
            addressTF.layer.shadowRadius = 4.0
            
            address2TF.layer.borderWidth = 1
            address2TF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            address2TF.placeholder = "Apt,Suite,Unit,Floor,Etc"
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.address2TF.frame.height))
            address2TF.leftView = paddingView
            address2TF.leftViewMode = UITextFieldViewMode.always
            address2TF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            address2TF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            address2TF.layer.shadowOpacity = 1.0
            address2TF.layer.shadowRadius = 4.0
            
            cityTF.layer.borderWidth = 1
            cityTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            cityTF.placeholder = "City"
            let cpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.cityTF.frame.height))
            cityTF.leftView = cpaddingView
            cityTF.leftViewMode = UITextFieldViewMode.always
            cityTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            cityTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            cityTF.layer.shadowOpacity = 1.0
            cityTF.layer.shadowRadius = 4.0
            
            stateTF.layer.borderWidth = 1
            stateTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            stateTF.placeholder = "State"
            let spaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.stateTF.frame.height))
            stateTF.leftView = spaddingView
            stateTF.leftViewMode = UITextFieldViewMode.always
            stateTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            stateTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            stateTF.layer.shadowOpacity = 1.0
            stateTF.layer.shadowRadius = 4.0
            
            zipTF.layer.borderWidth = 1
            zipTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            zipTF.placeholder = "Zip"
            let zpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.zipTF.frame.height))
            zipTF.leftView = zpaddingView
            zipTF.leftViewMode = UITextFieldViewMode.always
            zipTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            zipTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            zipTF.layer.shadowOpacity = 1.0
            zipTF.layer.shadowRadius = 4.0
            
            countryTF.layer.borderWidth = 1
            countryTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            countryTF.placeholder = "Country"
            let countrypaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.countryTF.frame.height))
            countryTF.leftView = countrypaddingView
            countryTF.leftViewMode = UITextFieldViewMode.always
            countryTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            countryTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            countryTF.layer.shadowOpacity = 1.0
            countryTF.layer.shadowRadius = 4.0
            
            self.continuebtn.layer.cornerRadius = 10
            self.continuebtn.clipsToBounds = true
            
        }
        else
        {
            deliveryview.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            deliveryview.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            deliveryview.layer.shadowOpacity = 1.0
            deliveryview.layer.shadowRadius = 20.0
            
            addressTF.layer.borderWidth = 1
            addressTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            addressTF.placeholder =  "Address Line 1"
            let addpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.addressTF.frame.height))
            addressTF.leftView = addpaddingView
            addressTF.leftViewMode = UITextFieldViewMode.always
            addressTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            addressTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            addressTF.layer.shadowOpacity = 1.0
            addressTF.layer.shadowRadius = 8.0
            
            address2TF.layer.borderWidth = 1
            address2TF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            address2TF.placeholder = "Apt,Suite,Unit,Floor,Etc"
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.address2TF.frame.height))
            address2TF.leftView = paddingView
            address2TF.leftViewMode = UITextFieldViewMode.always
            address2TF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            address2TF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            address2TF.layer.shadowOpacity = 1.0
            address2TF.layer.shadowRadius = 8.0
            
            cityTF.layer.borderWidth = 1
            cityTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            cityTF.placeholder = "City"
            let cpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.cityTF.frame.height))
            cityTF.leftView = cpaddingView
            cityTF.leftViewMode = UITextFieldViewMode.always
            cityTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            cityTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            cityTF.layer.shadowOpacity = 1.0
            cityTF.layer.shadowRadius = 8.0
            
            stateTF.layer.borderWidth = 1
            stateTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            stateTF.placeholder = "State"
            let spaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.stateTF.frame.height))
            stateTF.leftView = spaddingView
            stateTF.leftViewMode = UITextFieldViewMode.always
            stateTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            stateTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            stateTF.layer.shadowOpacity = 1.0
            stateTF.layer.shadowRadius = 8.0
            
            zipTF.layer.borderWidth = 1
            zipTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            zipTF.placeholder = "Zip"
            let zpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.zipTF.frame.height))
            zipTF.leftView = zpaddingView
            zipTF.leftViewMode = UITextFieldViewMode.always
            zipTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            zipTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            zipTF.layer.shadowOpacity = 1.0
            zipTF.layer.shadowRadius = 8.0
            
            countryTF.layer.borderWidth = 1
            countryTF.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            countryTF.placeholder = "Country"
            let countrypaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.countryTF.frame.height))
            countryTF.leftView = countrypaddingView
            countryTF.leftViewMode = UITextFieldViewMode.always
            countryTF.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            countryTF.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            countryTF.layer.shadowOpacity = 1.0
            countryTF.layer.shadowRadius = 8.0
            
            self.continuebtn.layer.cornerRadius = 20
            self.continuebtn.clipsToBounds = true
            
            let backbutton = UIButton(type: .custom)
            backbutton.setImage(UIImage(named: "back.png"), for: .normal)
            backbutton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            backbutton.addTarget(self, action: #selector(popvc), for: .touchUpInside)
            let backbuttonitem = UIBarButtonItem(customView: backbutton)
            self.navigationItem.leftBarButtonItem = backbuttonitem
        }
        
        
            self.navigationItem.setHidesBackButton(false, animated:true);
            
            let backbutton = UIButton(type: .custom)
            backbutton.setImage(UIImage(named: "back.png"), for: .normal)
            backbutton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            backbutton.addTarget(self, action: #selector(popvc), for: .touchUpInside)
            let backbuttonitem = UIBarButtonItem(customView: backbutton)
            self.navigationItem.leftBarButtonItem = backbuttonitem
        
        // Do any additional setup after loading the view.
        
        if customAddressList.count != 0 {
            let loadAddress = customAddressList[0]
            addressTF.text = loadAddress.strAddress
            cityTF.text = loadAddress.strCity
            stateTF.text = loadAddress.strState
            zipTF.text = loadAddress.strZip
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
    
    @IBAction func continueaction(_ sender: Any) {
        let loadAddress = AddressList()
        loadAddress.strAddress = addressTF.text
        loadAddress.strCity = cityTF.text
        loadAddress.strState =  stateTF.text
        loadAddress.strZip = zipTF.text
        let strf1 = loadAddress.strAddress?.appending(",\n").appending(loadAddress.strCity!).appending(",\n")
        let strf2 = strf1?.appending(loadAddress.strState!).appending(",\n")
        let strf3 = strf2?.appending(loadAddress.strZip!)
        loadAddress.strFullAddress =  strf3
        FireAuthModel().setdefaultAddress(addcount: "0", value: loadAddress)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DeliveryDateTimeViewController") as! DeliveryDateTimeViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    /*   func isValidation() -> Bool {
     if addressTF.text == ""
     {
     let alert = UIAlertController(title: "Alert", message: "Please Enter Your address.", preferredStyle: .alert)
     let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
     alert.addAction(defaultAction)
     present(alert, animated: true, completion: nil)
     return false
     }
     else if address2TF.text == ""
     {
     let alert = UIAlertController(title: "Alert", message: "Please Enter Your addressline 2.", preferredStyle: .alert)
     let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
     alert.addAction(defaultAction)
     present(alert, animated: true, completion: nil)
     return false
     
     }
     else if cityTF.text == ""
     {
     let alert = UIAlertController(title: "Alert", message: "Please Enter Your city.", preferredStyle: .alert)
     let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
     alert.addAction(defaultAction)
     present(alert, animated: true, completion: nil)
     return false
     }
     else if stateTF.text == ""
     {
     let alert = UIAlertController(title: "Alert", message: "Please Enter Your state.", preferredStyle: .alert)
     let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
     alert.addAction(defaultAction)
     present(alert, animated: true, completion: nil)
     return false
     }
     else if zipTF.text == ""
     {
     let alert = UIAlertController(title: "Alert", message: "Please Enter Your zip.", preferredStyle: .alert)
     let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
     alert.addAction(defaultAction)
     present(alert, animated: true, completion: nil)
     return false
     }
     else if countryTF.text == ""
     {
     let alert = UIAlertController(title: "Alert", message: "Please Enter Your country.", preferredStyle: .alert)
     let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
     alert.addAction(defaultAction)
     present(alert, animated: true, completion: nil)
     return false
     }
     return true
     
     
     } */
    /*    @IBAction func continueaction(_ sender: Any) {
     
     
     if isValidation() {
     
     emailpreference = "NO"
     smspreference = "NO"
     if numberofaddress == "Not Exsist"
     {
     let Addressdetails = ["address":self.addressTF.text! as String,
     "address2": self.address2TF.text! as String,
     "city": self.cityTF.text! as String,
     "country": self.countryTF.text! as String,
     "state": self.stateTF.text! as String,
     "zip": self.zipTF.text! as String
     ]
     
     self.Address.child("address").child("0").setValue(Addressdetails)
     
     if UIDevice.current.userInterfaceIdiom == .phone
     {
     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
     
     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Preference") as! EmailPreferenceView
     self.navigationController?.pushViewController(nextViewController, animated: true)
     }
     else
     {
     let storyBoard : UIStoryboard = UIStoryboard(name: "ipad", bundle:nil)
     
     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Preference") as! EmailPreferenceView
     self.navigationController?.pushViewController(nextViewController, animated: true)
     }
     }
     else
     {
     let customerdetails = ["address":self.addressTF.text! as String,
     "address2": self.address2TF.text! as String,
     "city": self.cityTF.text! as String,
     "country": self.countryTF.text! as String,
     "state": self.stateTF.text! as String,
     "zip": self.zipTF.text! as String
     ]
     
     //adding the artist inside the generated unique key
     self.Address.child("address").child(numberofaddress).setValue(customerdetails)
     
     if UIDevice.current.userInterfaceIdiom == .phone
     {
     if isdeviveryaddress {
     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
     
     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DeliveryDateTimeViewController") as! DeliveryDateTimeViewController
     self.navigationController?.pushViewController(nextViewController, animated: true)
     }else {
     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
     
     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Preference") as! EmailPreferenceView
     self.navigationController?.pushViewController(nextViewController, animated: true)
     }
     }
     else
     {
     let storyBoard : UIStoryboard = UIStoryboard(name: "ipad", bundle:nil)
     
     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Preference") as! EmailPreferenceView
     self.navigationController?.pushViewController(nextViewController, animated: true)
     }
     }
     }
     } */
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

