//
//  HomeViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 01/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SDWebImage
import DropDown

class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var collectionview1: UICollectionView!
    @IBOutlet weak var heightconstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionview2: UICollectionView!
    @IBOutlet weak var collectionview3: UICollectionView!
    var AvailableProducts: DatabaseReference!
    var AvailableProductsArray = [ProductDropDown]()
    var AvailProductsDropDown = NSMutableArray()
    var PopularitemsArray = [ProductDropDown]()
    var PopularitemsDropDown = NSMutableArray()
    var appDelegate = AppDelegate()
    var DataProductsArray = [RecentOrders]()
    var RecentVarientArray : [String] = []
    var RecentitemsDropDown = NSMutableArray()
    var selectedint: Int!
    var selecteditemvalue: String!
    
    let varientdropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.varientdropDown
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(useruid)
        
        self.navigationController?.isNavigationBarHidden = false

        appDelegate = UIApplication.shared.delegate as! AppDelegate

        searchview.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
        searchview.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        searchview.layer.shadowOpacity = 1.0
        searchview.layer.shadowRadius = 10.0
        
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            searchview.layer.cornerRadius = 10.0
            searchview.layer.borderWidth = 1.0
        }
        else
        {
            searchview.layer.cornerRadius = 20.0
            searchview.layer.borderWidth = 2.0
        }
        searchview.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            let titleview = UIView(frame: CGRect(x: 100, y: 100, width: 150, height: 40))
            titleview.backgroundColor = UIColor.clear
            let titlelabel = UILabel(frame: CGRect(x: 35, y: 5, width: 100, height: 30))
            titlelabel.text = "2Hr Grocery"
            titlelabel.textColor = UIColor(red:0.20, green:0.59, blue:0.99, alpha:1.0)
            titlelabel.font = UIFont(name: "OpenSans-Bold", size: 16)
            let titleimage = UIImageView(frame: CGRect(x: 10, y: 8, width: 25, height: 25))
            titleimage.image = UIImage(named: "cart.png")
            titleimage.contentMode = UIViewContentMode.scaleAspectFit
            titleview.addSubview(titlelabel)
            titleview.addSubview(titleimage)
            self.navigationItem.titleView = titleview
        }
        else
        {
            let titleview = UIView(frame: CGRect(x: 100, y: 100, width: 150, height: 40))
            titleview.backgroundColor = UIColor.clear
            let titlelabel = UILabel(frame: CGRect(x: 40, y: 5, width: 200, height: 30))
            titlelabel.text = "2Hr Grocery"
            titlelabel.textColor = UIColor(red:0.20, green:0.59, blue:0.99, alpha:1.0)
            titlelabel.font = UIFont(name: "OpenSans-Bold", size: 22)
            let titleimage = UIImageView(frame: CGRect(x: 10, y: 5, width: 30, height: 30))
            titleimage.image = UIImage(named: "cart.png")
            titleimage.contentMode = UIViewContentMode.scaleAspectFit
            titleview.addSubview(titlelabel)
            titleview.addSubview(titleimage)
            self.navigationItem.titleView = titleview
        }
        

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

        self.collectionview2.dataSource = self
        self.collectionview2.delegate = self
       
        self.collectionview3.dataSource = self
        self.collectionview3.delegate = self
        
        self.collectionview2.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        self.collectionview3.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        self.productforsale()
        self.popularitems()
       
    }
    
    func productforsale()
    {
        AvailableProducts = Database.database().reference().child("productsForSale")
        
        AvailableProducts.observe(DataEventType.value, with: { (snapshot) in
            
            for product in snapshot.children.allObjects as! [DataSnapshot]
            {
                let ProductObject =  product.value as? NSDictionary
                let Productcategory = ProductObject?.value(forKey: "categories") as AnyObject
                //                let artistcategory  = artistObject?["categories"]
                let isonSale = Productcategory["onSale"] as? Bool ?? false
                if isonSale
                {
                    
                    let Productbrand = ProductObject?.value(forKey: "brand") as! String
                    let ProductDesc = ProductObject?.value(forKey: "description") as! String
                    let ProductName = ProductObject?.value(forKey: "name") as! String
                    let ProductId = ProductObject?.value(forKey: "productID") as! String
                    let Productallimages = ProductObject?.value(forKey: "image") as AnyObject
                    let Productimage = Productallimages.value(forKey: "128") as! String
                    
                    let productsar = ProductDropDown(ProductId: ProductId, ProductDesc: ProductDesc, ProductName: ProductName, Productbrand: Productbrand, Productimage: Productimage)
                    self.AvailableProductsArray.append(productsar)
                    //self.tempTest[product.key] = Productdetails
                    
                    
                    let productdropdownarr = ProductObject?.value(forKey: "productVariant") as! NSArray
                    
                    self.AvailProductsDropDown.add(productdropdownarr)
                    print("Popularitems count \(self.AvailableProductsArray.count)")
                    
                }
                self.collectionview2.reloadData()
            }
        })
    }
    
    func popularitems()
    {
        AvailableProducts = Database.database().reference().child("productsForSale")
        
        AvailableProducts.observe(DataEventType.value, with: { (snapshot) in
            
            for product in snapshot.children.allObjects as! [DataSnapshot]
            {
                let ProductObject =  product.value as? NSDictionary
                let Productcategory = ProductObject?.value(forKey: "categories") as AnyObject
                //                let artistcategory  = artistObject?["categories"]
                let isPopular = Productcategory["isPopular"] as? Bool ?? false
                if isPopular
                {
                    let ProductObject =  product.value as? NSDictionary
                    
                    let Productbrand = ProductObject?.value(forKey: "brand") as! String
                    let ProductDesc = ProductObject?.value(forKey: "description") as! String
                    let ProductName = ProductObject?.value(forKey: "name") as! String
                    let ProductId = ProductObject?.value(forKey: "productID") as! String
                    let Productallimages = ProductObject?.value(forKey: "image") as AnyObject
                    let Productimage = Productallimages.value(forKey: "128") as! String
                    
                    let productsar = ProductDropDown(ProductId: ProductId, ProductDesc: ProductDesc, ProductName: ProductName, Productbrand: Productbrand, Productimage: Productimage)
                    self.PopularitemsArray.append(productsar)
                    
                    let productdropdownarr = ProductObject?.value(forKey: "productVariant") as! NSArray
                    
                    self.PopularitemsDropDown.add(productdropdownarr)
                    print("available count \(self.PopularitemsArray.count)")
                    
                }
            }
            self.collectionview3.reloadData()
            
        })
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = false
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        print(useruid)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func cart(sender: UIButton)
    {
        if useruid != "" {
            if UIDevice.current.userInterfaceIdiom == .phone
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            else
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "ipad", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
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
        for controller in self.navigationController!.viewControllers as Array
        {
            if controller.isKind(of: FirstViewController.self)
            {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func uicolorFromHex(rgbValue:UInt32)->UIColor
    {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    @IBAction func GroceryActn(_ sender: Any)
    {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Grocery") as! GroceryViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "ipad", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Grocery") as! GroceryViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == self.collectionview2
        {
            return AvailableProductsArray.count
        }
        else
        {
            return PopularitemsArray.count
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 135.0, height: 260.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(5, 10, 5, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionview2
        {
            let cell : HomeViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! HomeViewCell
            
            let product: ProductDropDown
            product = AvailableProductsArray[indexPath.row]
            cell.namelbl.text = product.ProductName
            cell.img.sd_setImage(with:URL(string: product.Productimage!))
            
            cell.Innerview.layer.borderColor = UIColor(red:0.92, green:0.93, blue:0.94, alpha:1.0).cgColor
            cell.Innerview.layer.borderWidth = 1.0
            
            cell.bgview.layer.borderColor = UIColor(red:0.92, green:0.93, blue:0.94, alpha:1.0).cgColor
            cell.bgview.layer.borderWidth = 1.0
            cell.bgview.clipsToBounds = true
            cell.bgview.layer.cornerRadius = 12
            
            cell.bgview.layer.shadowColor = UIColor.lightGray.cgColor
            cell.bgview.layer.shadowOffset = CGSize(width:0,height: 2.0)
            cell.bgview.layer.shadowRadius = 1.0
            cell.bgview.layer.shadowOpacity = 1.0
            cell.bgview.layer.masksToBounds = false;
            
            let filterarr = (self.AvailProductsDropDown.object(at: indexPath.item) as! NSArray)
            print(filterarr)
            cell.varientlbl.text = String(format:"%@.  $%d",((filterarr.object(at: 0) as! NSDictionary).value(forKey: "unit") as! String),((filterarr.object(at: 0) as! NSDictionary).value(forKey: "regularPrice") as! Int))
            cell.varientlbl.tag = indexPath.item
            
            print(selectedint)
            if selectedint != nil
            {
                if cell.varientlbl.tag == selectedint
                {
                    cell.varientlbl.text = selecteditemvalue
                }
            }
            cell.varientButton.addTarget(self, action: #selector(Availablevareintaction(sender:)), for: .touchUpInside)
            
            return cell
        }
        else
        {
            let cell : HomeViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! HomeViewCell
            
            let product: ProductDropDown
            product = PopularitemsArray[indexPath.row]
            cell.namelbl.text = product.ProductName
            cell.img.sd_setImage(with:URL(string: product.Productimage!))
            
            cell.Innerview.layer.borderColor = UIColor(red:0.92, green:0.93, blue:0.94, alpha:1.0).cgColor
            cell.Innerview.layer.borderWidth = 1.0
            
            cell.bgview.layer.borderColor = UIColor(red:0.92, green:0.93, blue:0.94, alpha:1.0).cgColor
            cell.bgview.layer.borderWidth = 1.0
            cell.bgview.clipsToBounds = true
            cell.bgview.layer.cornerRadius = 12
            
            cell.bgview.layer.shadowColor = UIColor.lightGray.cgColor
            cell.bgview.layer.shadowOffset = CGSize(width:0,height: 2.0)
            cell.bgview.layer.shadowRadius = 1.0
            cell.bgview.layer.shadowOpacity = 1.0
            cell.bgview.layer.masksToBounds = false;
            
            let filterarr = (self.PopularitemsDropDown.object(at: indexPath.item) as! NSArray)
            print(filterarr)
            cell.varientlbl.text = String(format:"%@.  $%d",((filterarr.object(at: 0) as! NSDictionary).value(forKey: "unit") as! String),((filterarr.object(at: 0) as! NSDictionary).value(forKey: "regularPrice") as! Int))
            cell.varientlbl.tag = indexPath.item
            
            print(selectedint)
            if selectedint != nil
            {
                if cell.varientlbl.tag == selectedint
                {
                    cell.varientlbl.text = selecteditemvalue
                }
            }
            
            cell.varientButton.addTarget(self, action: #selector(Popularvareintaction(sender:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    @objc func Popularvareintaction(sender: UIButton) {
        
        self.collectionview3.reloadData()
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let buttonPosition:CGPoint = sender.convert(.zero, to:self.collectionview3)
        let indexPath = self.collectionview3.indexPathForItem(at: buttonPosition)
        
        let cell : HomeViewCell = self.collectionview3.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as! IndexPath) as! HomeViewCell
        
        selectedint = indexPath!.item
        
        varientdropDown.anchorView = cell.dropview
        varientdropDown.width = 130
        varientdropDown.direction = .top
        varientdropDown.bottomOffset = CGPoint(x: buttonPosition.x, y: (screenHeight-buttonPosition.y))
        
        let filterrecentvarientarr = (self.PopularitemsDropDown.object(at: indexPath!.item) as! NSArray)
        print(filterrecentvarientarr)
        print(filterrecentvarientarr.count)
        
        self.RecentVarientArray.removeAll()
        
        for varientindex in 0..<filterrecentvarientarr.count
        {
            print((filterrecentvarientarr.object(at: varientindex) as! NSDictionary).value(forKey: "unit") as! String)
            let dropdownstr = String(format:"%@.  $%d",((filterrecentvarientarr.object(at: varientindex) as! NSDictionary).value(forKey: "unit") as! String),((filterrecentvarientarr.object(at: varientindex) as! NSDictionary).value(forKey: "regularPrice") as! Int))
            print(dropdownstr)
            self.RecentVarientArray.append(dropdownstr)
            
        }
        
        varientdropDown.dataSource = self.RecentVarientArray
        
        varientdropDown.show()
        self.collectionview3.reloadData()
        
        varientdropDown.selectionAction = { [weak self] (index, selecteditem) in
            
            cell.varientlbl.text = selecteditem
            self!.selecteditemvalue = selecteditem
           // NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];
            let indexpath1 = IndexPath(row: indexPath!.item, section: 0)
            self!.collectionview3.reloadItems(at: [indexpath1])//reloadItems(at: [indexPath!])
        }
    }
    
    @objc func Availablevareintaction(sender: UIButton) {
        
        self.collectionview2.reloadData()
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let buttonPosition:CGPoint = sender.convert(.zero, to:self.collectionview2)
        let indexPath = self.collectionview2.indexPathForItem(at: buttonPosition)
        
        let cell : HomeViewCell = self.collectionview2.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as! IndexPath) as! HomeViewCell
        
        selectedint = indexPath!.item
        
        varientdropDown.anchorView = cell.dropview
        varientdropDown.width = 130
        varientdropDown.direction = .any
        varientdropDown.bottomOffset = CGPoint(x: buttonPosition.x, y: (screenHeight-buttonPosition.y))
        
        
        let filterrecentvarientarr = (self.AvailProductsDropDown.object(at: indexPath!.item) as! NSArray)
        print(filterrecentvarientarr)
        print(filterrecentvarientarr.count)
        
        self.RecentVarientArray.removeAll()
        
        for varientindex in 0..<filterrecentvarientarr.count
        {
            print((filterrecentvarientarr.object(at: varientindex) as! NSDictionary).value(forKey: "unit") as! String)
            let dropdownstr = String(format:"%@.  $%d",((filterrecentvarientarr.object(at: varientindex) as! NSDictionary).value(forKey: "unit") as! String),((filterrecentvarientarr.object(at: varientindex) as! NSDictionary).value(forKey: "regularPrice") as! Int))
            print(dropdownstr)
            self.RecentVarientArray.append(dropdownstr)
        }
        
        varientdropDown.dataSource = self.RecentVarientArray
        
        varientdropDown.show()
        self.collectionview2.reloadData()
        
        varientdropDown.selectionAction = { [weak self] (index, selecteditem) in
            
            cell.varientlbl.text = selecteditem
            self!.selecteditemvalue = selecteditem
            // NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];
            let indexpath1 = IndexPath(row: indexPath!.item, section: 0)
            self!.collectionview2.reloadItems(at: [indexpath1])//reloadItems(at: [indexPath!])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == self.collectionview2
        {
            print(indexPath.row)
            
            let product: ProductDropDown
            product = AvailableProductsArray[indexPath.row]
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GroceryDetail") as! GroceryDetailView
            nextViewController.brandstr = product.Productbrand
            nextViewController.namestr = product.ProductName
            nextViewController.descriptionstr = product.ProductDesc
            nextViewController.imagestr = product.Productimage
            nextViewController.productid = product.ProductId
            nextViewController.DropDownArray = (self.AvailProductsDropDown.object(at: indexPath.item) as! NSArray)
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        else if collectionView == self.collectionview3
        {
            print(indexPath.row)
            
            let product: ProductDropDown
            product = PopularitemsArray[indexPath.row]
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GroceryDetail") as! GroceryDetailView
            nextViewController.brandstr = product.Productbrand
            nextViewController.namestr = product.ProductName
            nextViewController.descriptionstr = product.ProductDesc
            nextViewController.imagestr = product.Productimage
            nextViewController.productid = product.ProductId
            nextViewController.DropDownArray = (self.PopularitemsDropDown.object(at: indexPath.item) as! NSArray)
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
    }

}
