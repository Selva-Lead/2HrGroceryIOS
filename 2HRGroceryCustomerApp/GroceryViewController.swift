//
//  GroceryViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 04/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SDWebImage

class GroceryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var titleview: UIView!
    @IBOutlet weak var searchview: UIView!
    var Products: DatabaseReference!
    var appDelegate = AppDelegate()
    var Productarray = [ProductDropDown]()
    var DropDown = NSMutableArray()
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchview.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
        searchview.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        searchview.layer.shadowOpacity = 1.0
        searchview.layer.shadowRadius = 12.0
        
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            searchview.layer.cornerRadius = 12.0
            searchview.layer.borderWidth = 1.0
        }
        else
        {
            searchview.layer.cornerRadius = 24.0
            searchview.layer.borderWidth = 2.0
        }
        searchview.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate

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
        
        table.delegate = self
        table.dataSource = self

        table.backgroundColor = UIColor.clear
        table.register(UINib(nibName:"ProductsCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        Products = Database.database().reference().child("productsForSale")
        
        Products.observe(DataEventType.value, with: { (snapshot) in
            
            for product in snapshot.children.allObjects as! [DataSnapshot]
            {
                let ProductObject =  product.value as? NSDictionary
                let Productcategory = ProductObject?.value(forKey: "categories") as AnyObject
//                let artistcategory  = artistObject?["categories"]
               // print(Productcategory["Grocery"] as! AnyObject)
                let isGrocery = Productcategory["Grocery"] as? Bool ?? false
                if isGrocery
                {
                    /*let Productdetails = ProductDropDown()
                    Productdetails.Productbrand = ProductObject?.value(forKey: "brand") as! String
                    Productdetails.ProductDesc = ProductObject?.value(forKey: "description") as! String
                    Productdetails.ProductId = ProductObject?.value(forKey: "productID") as! String
                    Productdetails.ProductName = ProductObject?.value(forKey: "name") as! String
                    let Productallimages = ProductObject?.value(forKey: "image") as AnyObject
                    Productdetails.Productimage = Productallimages.value(forKey: "128") as! String */

//                    tempProductTopDown.productVarient(tempProductTopDown.ProductId) = (ProductObject?.value(forKey: "productVariant") as AnyObject) as! [String:ProductVarient]
                    let Productbrand = ProductObject?.value(forKey: "brand") as AnyObject
                    let ProductDesc = ProductObject?.value(forKey: "description") as AnyObject
                    let ProductName = ProductObject?.value(forKey: "name") as AnyObject
                    let ProductId = ProductObject?.value(forKey: "productID") as AnyObject
                    let Productallimages = ProductObject?.value(forKey: "image") as AnyObject
                    let Productimage = Productallimages.value(forKey: "128") as! String
                    
                   let productsar = ProductDropDown(ProductId: ProductId as? String, ProductDesc: ProductDesc as? String, ProductName: ProductName as? String, Productbrand: Productbrand as? String, Productimage: Productimage as? String)
                    self.Productarray.append(productsar)
                    //self.tempTest[product.key] = Productdetails


                    let productdropdownarr = ProductObject?.value(forKey: "productVariant") as! NSArray
            
                    self.DropDown.add(productdropdownarr)
                    print("self.Productarray.count count\(self.Productarray.count)")
                    
                }
                
                self.table.reloadData()

                //print(artistObject as Any)
                

              /*  let artistName  = artistObject?["artistName"]
                let artistId  = artistObject?["id"]
                let artistGenre = artistObject?["artistGenre"]
                
                //creating artist object with model and fetched values
                let artist = ArtistModel(id: artistId as! String?, name: artistName as! String?, genre: artistGenre as! String?)
                
                //appending it to list
                self.artistList.append(artist) */
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func cart(sender: UIButton)
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
    
    @objc func popvc(sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Productarray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 96
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = table.dequeueReusableCell(withIdentifier:"Cell", for: indexPath as IndexPath) as! ProductsCell
        cell.selectionStyle = .none
        
        let product: ProductDropDown
        product = Productarray[indexPath.row]

        cell.NameLbl.text = product.ProductName
        cell.BrandLbl.text = "Brand: \(String(describing: product.Productbrand!))"
        
        cell.Img.sd_setImage(with:URL(string: product.Productimage!))
        
        cell.addcartbtn.layer.cornerRadius = 8.0
        cell.addcartbtn.clipsToBounds = true
        
        cell.Img.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        cell.Img.layer.borderWidth = 0.5
        cell.Img.layer.cornerRadius = 8
        cell.Img.clipsToBounds = true
        
        cell.dropview.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        cell.dropview.layer.borderWidth = 0.5
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let product: ProductDropDown
        product = Productarray[indexPath.row]
        
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GroceryDetail") as! GroceryDetailView
            nextViewController.brandstr = product.Productbrand
            nextViewController.namestr = product.ProductName
            nextViewController.descriptionstr = product.ProductDesc
            nextViewController.imagestr = product.Productimage
            nextViewController.productid = product.ProductId
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "ipad", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GroceryDetail") as! GroceryDetailView
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
