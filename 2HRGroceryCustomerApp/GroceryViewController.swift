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

class GroceryViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, UITextFieldDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var titleview: UIView!
    @IBOutlet weak var searchview: UIView!
    var Products: DatabaseReference!
    var appDelegate = AppDelegate()
    var Productarray = [GroceryVarients]()
    var DropDownArray = NSMutableArray()
    var DropDownArr = [ProductInvarient]()
    var selectedCell : Int?
    @IBOutlet weak var grocerylist: UICollectionView!
    
    var issearch = Bool()
    var tapper = UITapGestureRecognizer()
    var searchDropDownArr = NSMutableArray()
    var searchArray = [GroceryVarients]()
    var searchTerm:String!
    
    var selectedint: Int!
    var selecteditemvalue: String!
    
    var ProductVarientArray : [String] = []
    
    let progressHUD = ProgressHUD(text: "Loading...")
    
    let productdropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.productdropDown
        ]
    }()
    
    var screenSize : CGRect!
    var screenWidth : CGFloat!
    var screenHeight : CGFloat!
    
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
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        self.grocerylist.dataSource = self
        self.grocerylist.delegate = self
        
        self.grocerylist.register(UINib(nibName: "GroceryCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        grocerylist.backgroundColor = UIColor.clear
        
        if currentReachabilityStatus != .notReachable
        {
            DispatchQueue.global(qos: .userInitiated).async
            {
                DispatchQueue.main.async
                {
                    self.view.addSubview(self.progressHUD)
                    self.groceries()
                    self.view.isUserInteractionEnabled=false
                }
            }
        }
        else
        {
            let alert = UIAlertController(title: "Alert", message: "No Internet Connection.Please try again later", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func groceries()
    {
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
                //self.grocerylist.reloadData()
            }
            self.progressHUD.hide()
            self.view.isUserInteractionEnabled = true
            DispatchQueue.main.async {
                self.grocerylist.reloadData()
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
                            self.grocerylist.reloadData()
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
        self.grocerylist.reloadData()
    }
    
    @objc func cart(sender: UIButton)
    {
        if useruid != ""
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        //return CGSize(width: (screenWidth-10), height: 50)
        return CGSize(width: screenWidth-10, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
       // return UIEdgeInsetsMake(5, 10, 5, 10)
        return UIEdgeInsetsMake(5, 10, 5, 10)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : GroceryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! GroceryCell
        if issearch == true
        {
            let cell : GroceryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! GroceryCell
            let product: GroceryVarients
            product = searchArray[indexPath.row] 
            
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
            
            cell.varientlbl.tag = indexPath.item
            
            cell.varientlbl.text = String(format:"%@.  $%d",((product.ProductVarient!.object(at: 0) as! NSDictionary).value(forKey: "unit") as! String),((product.ProductVarient!.object(at: 0) as! NSDictionary).value(forKey: "regularPrice") as! Int))
            
            cell.productdropbtn.tag = indexPath.item
            productdropDown.tag = indexPath.item
            
            if selectedint != nil
            {
                if cell.varientlbl.tag == selectedint
                {
                    cell.varientlbl.text = selecteditemvalue
                }
            }
            
            cell.productdropbtn.addTarget(self, action: #selector(Productvareintaction(sender:)), for: .touchUpInside)
            cell.addcartbtn.addTarget(self, action: #selector(addToCart(sender:)), for: .touchUpInside)
            return cell
        }
        else
        {
            let cell : GroceryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! GroceryCell
            let product: GroceryVarients
            product = Productarray[indexPath.row]
            
            cell.NameLbl.text = product.ProductName
            cell.BrandLbl.text = "Brand: \(String(describing: product.Productbrand!))"
            
            cell.Img.sd_setImage(with:URL(string: product.Productimage!))
            
            cell.addcartbtn.layer.cornerRadius = 8.0
            cell.addcartbtn.clipsToBounds = true
            cell.addcartbtn.tag = indexPath.item
            cell.addcartbtn.addTarget(self, action: #selector(addToCart(sender:)), for:.touchUpInside)
            
            cell.Img.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            cell.Img.layer.borderWidth = 0.5
            cell.Img.layer.cornerRadius = 8
            cell.Img.clipsToBounds = true
            
            cell.dropview.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
            cell.dropview.layer.borderWidth = 0.5
            
            cell.varientlbl.tag = indexPath.item
            
            cell.varientlbl.text = String(format:"%@.  $%d",((product.ProductVarient!.object(at: 0) as! NSDictionary).value(forKey: "unit") as! String),((product.ProductVarient!.object(at: 0) as! NSDictionary).value(forKey: "regularPrice") as! Int))
            
            cell.productdropbtn.tag = indexPath.item
            productdropDown.tag = indexPath.item
            
            if selectedint != nil
            {
                if cell.varientlbl.tag == selectedint
                {
                    cell.varientlbl.text = selecteditemvalue
                }
            }
            
            cell.productdropbtn.addTarget(self, action: #selector(Productvareintaction(sender:)), for: .touchUpInside)
            cell.addcartbtn.addTarget(self, action: #selector(addToCart(sender:)), for: .touchUpInside)
            return cell
        }
        return cell
    }
    
    @objc func Productvareintaction(sender: UIButton) {
        
        self.grocerylist.reloadData()
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let buttonPosition:CGPoint = sender.convert(.zero, to:self.grocerylist)
        let indexPath = self.grocerylist.indexPathForItem(at: buttonPosition)
        
        let cell : GroceryCell = self.grocerylist.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as! IndexPath) as! GroceryCell
        
        selectedint = indexPath!.item
        
        productdropDown.anchorView = cell.dropview
        productdropDown.width = 120
        productdropDown.direction = .any
       
        if buttonPosition.y > screenHeight
        {
            productdropDown.bottomOffset = CGPoint(x: (buttonPosition.x/screenWidth), y: (buttonPosition.y/screenHeight))
        }
        else
        {
            productdropDown.bottomOffset = CGPoint(x: buttonPosition.x, y: (screenHeight-buttonPosition.y))
        }
        cell.addSubview(productdropDown)
        
        let product: GroceryVarients
        
        if issearch == true
        {
            product = searchArray[indexPath!.item]
            DropDownArray = product.ProductVarient as! NSMutableArray
        }
        else
        {
            product = Productarray[indexPath!.item]
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
        self.grocerylist.reloadData()
        
        productdropDown.selectionAction = { [weak self] (index, selecteditem) in
            
            self!.selecteditemvalue = selecteditem
            let indexpath1 = IndexPath(row: indexPath!.item, section: 0)
            self!.grocerylist.reloadItems(at: [indexpath1])
        } 
    }
    
   /* func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
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
    } */
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let product: GroceryVarients
        
        if issearch == true
        {
            if UIDevice.current.userInterfaceIdiom == .phone
            {
                product = searchArray[indexPath.item]
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
                product = Productarray[indexPath.item]
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
