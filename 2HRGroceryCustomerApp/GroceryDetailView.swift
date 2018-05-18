//
//  GroceryDetailView.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 04/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import SDWebImage
import DropDown

class GroceryDetailView: UIViewController {

    @IBOutlet weak var brandlbl: UILabel!
    @IBOutlet weak var productnamelbl: UILabel!
    @IBOutlet weak var productdesclbl: UILabel!
    @IBOutlet weak var favoritebtn: UIButton!
    @IBOutlet weak var productimage: UIImageView!
    @IBOutlet weak var cartbtn: UIButton!
    @IBOutlet weak var dropview: UIView!
    @IBOutlet weak var dropbtn: UIButton!
    var VarientArrayList : [String] = []
    
    @IBOutlet weak var varientlbl: UILabel!
    var DropDownArray = NSArray()

    var brandstr :String!
    var namestr :String!
    var descriptionstr :String!
    var imagestr :String!
    var productid :String!
    var varientid :String!

    let listdropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.listdropDown
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UIDevice.current.userInterfaceIdiom == .phone
        {
            favoritebtn.layer.cornerRadius = 4.0
            cartbtn.layer.cornerRadius = 4.0
        }
        else
        {
            favoritebtn.layer.cornerRadius = 8.0
            cartbtn.layer.cornerRadius = 8.0
        }
        
        brandlbl.text = "Brand: \(brandstr!)"
        productnamelbl.text = "\(namestr!)"
        productdesclbl.text = "\(descriptionstr!)"
        productimage.sd_setImage(with:URL(string: imagestr!))
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "shoppingcart.png"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(cart), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "like.png"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(wishlist), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.setRightBarButtonItems([item1,item2], animated: true)
        
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back.png"), for: .normal)
        backbutton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backbutton.addTarget(self, action: #selector(popvc), for: .touchUpInside)
        let backbuttonitem = UIBarButtonItem(customView: backbutton)
        self.navigationItem.leftBarButtonItem = backbuttonitem
        SetuplistDropDown()
    }
    
    func SetuplistDropDown() {
        
        listdropDown.anchorView = dropview
        listdropDown.width = 120
        listdropDown.direction = .bottom
        listdropDown.bottomOffset = CGPoint(x: 0, y: dropbtn.bounds.height+10)
        
        print(DropDownArray)
        print(DropDownArray.count)
        
        self.VarientArrayList.removeAll()
        
        for index in 0..<DropDownArray.count
        {
            print((DropDownArray.object(at: index) as! NSDictionary).value(forKey: "unit") as! String)
            let dropdownstr = String(format:"%@.  $%d",((DropDownArray.object(at: index) as! NSDictionary).value(forKey: "unit") as! String),((DropDownArray.object(at: index) as! NSDictionary).value(forKey: "regularPrice") as! Int))
            print(dropdownstr)
            self.VarientArrayList.append(dropdownstr)
        }
        
        self.varientlbl.text = self.VarientArrayList[0]
        listdropDown.dataSource = self.VarientArrayList
        
        listdropDown.selectionAction = { [weak self] (index, item) in
            
            self!.varientid = String(format: "\(index)")
            print(self!.varientid)
            self!.varientlbl.text = item
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func cart(sender: UIButton)
    {
        if useruid != ""
        {
            if UIDevice.current.userInterfaceIdiom == .phone
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
        else
        {
            if UIDevice.current.userInterfaceIdiom == .phone
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            else
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "ipad", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
    }
    
    @objc func wishlist(sender: UIButton)
    {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "ipad", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    @IBAction func DropAction(_ sender: Any)
    {
        listdropDown.show()
    }
    
    @objc func popvc(sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cartAction(_ sender: Any)
    {
        if useruid != ""
        {
            var timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(tosterView), userInfo: nil, repeats: false)
            let addcart = AddCart()
            print(productid)
            addcart.strProductId = productid
            addcart.strTimeStamp = NSTimeIntervalSince1970
            addcart.strVarients = [self.varientid: "1" as AnyObject]
            FireAuthModel().addCarts(productForSaleID: productid!, valueAddCart: addcart)
        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    @objc func tosterView() {
        
    }
}
