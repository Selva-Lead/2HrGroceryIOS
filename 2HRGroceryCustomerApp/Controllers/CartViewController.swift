//
//  CartViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 03/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UIScrollViewDelegate {
   

    @ IBOutlet weak var cartTopView: UIView!
    @IBOutlet weak var cartTableView: UITableView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.delegate = self
        cartTopView.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        cartTopView.layer.borderWidth = 0.5
        cartTopView.layer.shadowColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        cartTopView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cartTopView.layer.shadowOpacity = 1.0
        cartTopView.layer.shadowRadius = 10.0
        FireAuthModel().getCartList(complition: {
            self.cartTableView.reloadData()
        })
        //cartTopView.layer.shadowPath = UIBezierPath(rect: cartTopView.bounds).cgPath
        
        //cartTableView.backgroundColor = UIColor.red
        //scrollview.backgroundColor = UIColor.red
       // btnCheckOut.setTitle("CHECKOUT - $", for: .normal)
        // Do any additional setup after loading the view.
       // self.cartTableView.register(CartListTableViewCell.self, forCellReuseIdentifier: "CartListTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Checkout(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DeliveryaddressViewController") as! DeliveryaddressViewController
        nextViewController.isdeviveryaddress = true
        self.navigationController?.pushViewController(nextViewController, animated: true)
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
extension CartViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return fullCartList.count
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCartTableViewCell") as! MainCartTableViewCell
        let cellCheckout = tableView.dequeueReusableCell(withIdentifier: "CheckOut") as! MainCartTableViewCell
        //if productForCart.count != 0 {
            if indexPath.section == 0 {
                
                var singleAddCart = AddCart()
                singleAddCart = fullCartList[indexPath.row]
                let varients = singleAddCart.strVarients
                //if varients
                let product = productForCart[singleAddCart.strProductId!]
                let imgurl = product?.strProductimage.first?.value as! String
                let imgURL = URL(string: imgurl)
                cell.imgProduct.backgroundColor = UIColor.clear
                cell.imgProduct.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
                cell.imgProduct.layer.borderWidth = 1
                cell.imgProduct.layer.cornerRadius = 3
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imgURL!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    DispatchQueue.main.async {
                        cell.imgProduct.image = UIImage(data: data!)
                    }
                }
                
                cell.lblBrandName.text = product?.strProductbrand
                cell.lblProductTitle.text = product?.strProductName
                //cell.lbl
                //let data = try? Data(contentOf: imgURL)
                //cell.imgProduct.image = UIImage. // product?.Productimage
                cell.lblProductQntyCount.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
                cell.lblProductQntyCount.layer.borderWidth = 1
                cell.lblProductQntyCount.layer.cornerRadius = 4
                cell.lblProductQntyCount.text = "10"
                return cell
            }else if indexPath.section == 1  {
                cellCheckout.btnCheckOut.titleLabel?.text = "CHECKOUT - $67.96"
                return cellCheckout
            }
        if indexPath.section == 0 {
            var singleAddCart = AddCart()
            singleAddCart = fullCartList[indexPath.row]
//            let product = productForSaleItems[singleAddCart.strProductId!]
            //cell.imgProduct.image = UIImage( // product?.Productimage
            cell.lblProductQntyCount.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
            cell.lblProductQntyCount.layer.borderWidth = 1
            cell.lblProductQntyCount.layer.cornerRadius = 4
            cell.lblProductQntyCount.text = "10"
            return cell
        }else if indexPath.section == 1  {
            cellCheckout.btnCheckOut.titleLabel?.text = "CHECKOUT - $67.96"
            return cellCheckout
        }
        return MainCartTableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
