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
import DropDown

class GroceryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var titleview: UIView!
    @IBOutlet weak var searchview: UIView!
    var Products: DatabaseReference!
    var appDelegate = AppDelegate()
    var Productarray = [GroceryVarients]()
    var DropDownArray = NSMutableArray()
    var DropDownArr = [ProductInvarient]()
    var selectedCell : Int?
    @IBOutlet var table: UITableView!

    var issearch = Bool()
    var tapper = UITapGestureRecognizer()
    var searchDropDownArr = NSMutableArray()
    var searchArray = [GroceryVarients]()
    var searchTerm:String!
    
    var ProductVarientArray : [String] = []
    
    let productdropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.productdropDown
        ]
    }()
    
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

        tapper = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap(_:)))
        tapper.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapper)
        
        searchTF.delegate = self
        
        searchTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

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
                let isGrocery = Productcategory["Grocery"] as? Bool ?? false
                if isGrocery
                {
                    let Productbrand = ProductObject?.value(forKey: "brand") as AnyObject
                    let ProductDesc = ProductObject?.value(forKey: "description") as AnyObject
                    let ProductName = ProductObject?.value(forKey: "name") as AnyObject
                    let ProductId = ProductObject?.value(forKey: "productID") as AnyObject
                    let Productallimages = ProductObject?.value(forKey: "image") as AnyObject
                    let Productimage = Productallimages.value(forKey: "128") as! String
                    
                    let varientarr = ProductObject?.value(forKey: "productVariant") as! NSArray

                   let productsar = GroceryVarients(ProductId: ProductId as? String, ProductDesc: ProductDesc as? String, ProductName: ProductName as? String, Productbrand: Productbrand as? String, Productimage: Productimage as? String, ProductVarient: varientarr as NSArray)
                    self.Productarray.append(productsar)
                    
                }
                self.table.reloadData()
            }
        })
    }

    @objc func handleSingleTap(_ sender: UITapGestureRecognizer)
    {
        searchTF.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        NSLog( "text changed: %@", textField.text!);
        searchTerm = textField.text;
        
        if (searchTerm.count>0)
        {
            issearch = true
            
            searchArray.removeAll()
            
            self.searchDropDownArr.removeAllObjects()
            
            for x in 0..<Productarray.count
            {
                let product: GroceryVarients
                product = Productarray[x]
                let y=Productarray[x]
                let name=Productarray[x]
                print(y)
                print(name)
                print(searchTerm)
                
                do {
                    let input = "\(product.ProductName!)"
                    let regex = try NSRegularExpression(pattern: searchTerm, options: NSRegularExpression.Options.caseInsensitive)
                    let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
                    
                    
                    for match in matches {
                        if let range = Range(match.range, in: input) {
                            let name = input[range]
                            print(name)
                            searchArray.append(y)
                            self.table.reloadData()
                        }
                    }
                } catch {
                    // regex was bad!
                }
            }
        }
        else
        {
            issearch = false
        }
        table.reloadData()
    }
    
    @objc func cart(sender: UIButton)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)

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
    @objc func toasterView() {
        let message = "product added to cart  "
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        alert.view.frame.size = CGSize(width: 250, height: 100)
        alert.view.tintColor = UIColor.black
        alert.view.tintAdjustmentMode = .normal
        self.present(alert, animated: false)
        
        // duration in seconds
        let duration: Double = 0.3
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: false)
        }
    }
    @objc func addToCart(sender: UIButton) {
        if useruid != "" {
            toasterView()
            
            if strCheckout == nil {
                var strValues = [String : AnyObject]()
                strValues["status"] = "cart" as AnyObject
                FireAuthModel().setOrderStatus(status: strValues)
            }
            
            let productCart = Productarray[sender.tag]
            let addcart = AddCart()
            print(productCart.ProductId)
            addcart.strProductId = productCart.ProductId
            addcart.strTimeStamp = round((Date().timeIntervalSince1970) * 1000)//NSTimeIntervalSince1970
            addcart.strVarients = ["0": 1 as AnyObject]
            FireAuthModel().addCarts(productForSaleID: productCart.ProductId!, valueAddCart: addcart)
        }else {
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if issearch == true
        {
            return searchArray.count
        }
        else
        {
            return Productarray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 96
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = table.dequeueReusableCell(withIdentifier:"Cell", for: indexPath as IndexPath) as! ProductsCell
        cell.selectionStyle = .none
        
        if issearch == true
        {
            let product: GroceryVarients
            product = searchArray[indexPath.row] as! GroceryVarients
            
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
            
            //cell.productdropbtn.addTarget(self, action: #selector(Productvareintaction(sender:)), for: .touchUpInside)
            cell.addcartbtn.addTarget(self, action: #selector(addToCart(sender:)), for: .touchUpInside)
        }
        else
        {
            let product: GroceryVarients
            product = Productarray[indexPath.row]
            
            cell.NameLbl.text = product.ProductName
            cell.BrandLbl.text = "Brand: \(String(describing: product.Productbrand!))"
            
            cell.Img.sd_setImage(with:URL(string: product.Productimage!))
            
            cell.addcartbtn.layer.cornerRadius = 8.0
            cell.addcartbtn.clipsToBounds = true
            cell.addcartbtn.tag = indexPath.row
            cell.addcartbtn.addTarget(self, action: #selector(addToCart(sender:)), for:.touchUpInside)
            
            cell.Img.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            cell.Img.layer.borderWidth = 0.5
            cell.Img.layer.cornerRadius = 8
            cell.Img.clipsToBounds = true
            
            cell.dropview.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            cell.dropview.layer.borderWidth = 0.5
            
            //cell.productdropbtn.addTarget(self, action: #selector(Productvareintaction(sender:)), for: .touchUpInside)
            cell.addcartbtn.addTarget(self, action: #selector(addToCart(sender:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    @objc func Productvareintaction(sender: UIButton) {
        
        let buttonPosition:CGPoint = sender.convert(.zero, to:self.table)
        let indexPath = self.table.indexPathForRow(at: buttonPosition)
        
        let cell = table.dequeueReusableCell(withIdentifier:"Cell", for: indexPath!) as! ProductsCell
        
        productdropDown.anchorView = cell.productdropbtn
        productdropDown.width = 120
        productdropDown.direction = .any
        productdropDown.bottomOffset = CGPoint(x: cell.frame.origin.x-90, y: buttonPosition.y)
        
        let product: GroceryVarients
        
        if issearch == true
        {
            product = searchArray[indexPath!.row]
            DropDownArray = product.ProductVarient as! NSMutableArray
        }
        else
        {
            product = Productarray[indexPath!.row]
            DropDownArray = product.ProductVarient as! NSMutableArray
        }
        
        self.ProductVarientArray.removeAll()
        
        for varientindex in 0..<DropDownArray.count
        {
            print((DropDownArray.object(at: varientindex) as! NSDictionary).value(forKey: "unit") as! String)
            let dropdownstr = String(format:"%@.  $%d",((DropDownArray.object(at: varientindex) as! NSDictionary).value(forKey: "unit") as! String),((DropDownArray.object(at: varientindex) as! NSDictionary).value(forKey: "regularPrice") as! Int))
            print(dropdownstr)
            self.ProductVarientArray.append(dropdownstr)
        }
        
        productdropDown.dataSource = self.ProductVarientArray
        
        productdropDown.show()
        
        productdropDown.selectionAction = { [weak self] (index, item) in
            //cell.productdropbtn.setTitle(item, for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let product: GroceryVarients
        
        if issearch == true
        {
            if UIDevice.current.userInterfaceIdiom == .phone
            {
                product = searchArray[indexPath.row]
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GroceryDetail") as! GroceryDetailView
                nextViewController.brandstr = product.Productbrand
                nextViewController.namestr = product.ProductName
                nextViewController.descriptionstr = product.ProductDesc
                nextViewController.imagestr = product.Productimage
                nextViewController.productid = product.ProductId
                nextViewController.DropDownArray = product.ProductVarient as! NSMutableArray
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            else
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "ipad", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GroceryDetail") as! GroceryDetailView
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
        else
        {
            if UIDevice.current.userInterfaceIdiom == .phone
            {
                product = Productarray[indexPath.row]
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GroceryDetail") as! GroceryDetailView
                nextViewController.brandstr = product.Productbrand
                nextViewController.namestr = product.ProductName
                nextViewController.descriptionstr = product.ProductDesc
                nextViewController.imagestr = product.Productimage
                nextViewController.productid = product.ProductId
                nextViewController.DropDownArray = product.ProductVarient as! NSMutableArray
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
}
