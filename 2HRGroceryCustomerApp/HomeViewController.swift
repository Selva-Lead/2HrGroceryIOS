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

    var appDelegate = AppDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        self.collectionview1.dataSource = self
        self.collectionview1.delegate = self
        
        self.collectionview2.dataSource = self
        self.collectionview2.delegate = self
       
        self.collectionview3.dataSource = self
        self.collectionview3.delegate = self
        
        self.collectionview1.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        self.collectionview2.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        self.collectionview3.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        self.collectionview1.reloadData()
        self.collectionview2.reloadData()
        self.collectionview3.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = false
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        print(useruid)
      
        if useruid == nil
        {
            view3.isHidden = true
           // heightconstraint.constant = 1000
        }
        else
        {
            view3.isHidden = false
           // heightconstraint.constant = 1300
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = false
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
        return 6
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
        return UIEdgeInsetsMake(2, 10, 2, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : HomeViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! HomeViewCell
        
        return cell
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
