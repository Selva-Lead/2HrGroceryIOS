//
//  CartViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 03/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UIScrollViewDelegate {
   

    @IBOutlet weak var cartTopView: UIView!
    @IBOutlet weak var cartTableView: UITableView!
    var selecetedIndex: Int!
    var selectedVarientKey: Int!
    var selectedQuantity: Int!
    var dicSelectedProductTolPrice: [Int:Float] = [Int: Float]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.delegate = self
        cartTopView.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        cartTopView.layer.borderWidth = 0.5
        cartTopView.layer.shadowColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        cartTopView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cartTopView.layer.shadowOpacity = 1.0
        cartTopView.layer.shadowRadius = 10.0
        
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back.png"), for: .normal)
        backbutton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backbutton.addTarget(self, action: #selector(popvc), for: .touchUpInside)
        let backbuttonitem = UIBarButtonItem(customView: backbutton)
        self.navigationItem.leftBarButtonItem = backbuttonitem
       // btnCheckOut.setTitle("CHECKOUT - $", for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if fullCartList.count != 0 {
            fullCartList.removeAll()
        }
        FireAuthModel().getCartList(complition: {
            self.cartTableView.reloadData()
        })
        super .viewWillAppear(animated)
    }
    @objc func popvc(sender: UIButton)
    {
        for addcartSingle in fullCartList {
            FireAuthModel().addCarts(productForSaleID: addcartSingle.strProductId!, valueAddCart: addcartSingle)
        }
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func emptyCart(_ sender: Any) {
        FIRUtils.getCartsDBRef().removeValue(completionBlock: {(error, databaseReference) in
            print("its compleated")
            fullCartList.removeAll()
            self.cartTableView.reloadData()
        })
    }
    @IBAction func Checkout(_ sender: UIButton) {
        var strValues = [String : AnyObject]()
        strValues["status"] = "checkout" as AnyObject
        FireAuthModel().setOrderStatus(status: strValues)
        strCheckout = "checkout"
        for addcartSingle in fullCartList {
            FireAuthModel().addCarts(productForSaleID: addcartSingle.strProductId!, valueAddCart: addcartSingle)
        }
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DeliveryOptionsViewController") as! DeliveryOptionsViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @objc func varientCountIncrease(sender: UIButton) {
        selecetedIndex = sender.tag
        let selectedProduct = fullCartList[selecetedIndex]
         let product = productForCart[selectedProduct.strProductId!]
        let varientValue = selectedProduct.strVarients["\(selectedVarientKey!)"] as! String
        selectedProduct.strVarients.removeValue(forKey: "\(selectedVarientKey)")
        selectedProduct.strVarients["\(selectedVarientKey!)"] = String(Int(varientValue)! + 1) as AnyObject
        //       let indexpath = IndexPath(row: selecetedIndex, section: 0)
        //        cartTableView.reloadRows(at: [indexpath], with: .none)
     cartTableView.reloadData()
    }
    @objc func varientCountDecrease(sender: UIButton) {
       dicSelectedProductTolPrice.removeAll()
        selecetedIndex = sender.tag
        let selectedProduct = fullCartList[selecetedIndex]
         let varientValue = selectedProduct.strVarients["\(selectedVarientKey!)"] as! String
        selectedProduct.strVarients.removeValue(forKey: "\(selectedVarientKey)")
        
        if Int(varientValue)! >= 1 {
            let strChangeValue = String(Int(varientValue)! - 1)
            selectedProduct.strVarients["\(selectedVarientKey!)"] = strChangeValue as AnyObject
            if Int(strChangeValue) == 0 {
                fullCartList.remove(at: selecetedIndex)
                FireAuthModel().removeCarts(productForSAleID: selectedProduct.strProductId!)
                 //[Int(selectedProduct.strProductId!)]
                 //dicSelectedProductTolPrice[selecetedIndex] = 0
            }
        }
       cartTableView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func checkOutTotalPrice() {
        var count = 0
        for cartList in dicSelectedProductTolPrice  {
           let value = cartList.value
            totalCheckOutPrice = totalCheckOutPrice + value
            count = count + 1
        }
    }
    
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
        totalCheckOutPrice = 0
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCartTableViewCell") as! MainCartTableViewCell
        let cellCheckout = tableView.dequeueReusableCell(withIdentifier: "CheckOut") as! MainCartTableViewCell
        cell.selectionStyle = .none
        cellCheckout.selectionStyle = .none
        if productForCart.count != 0 {
            if fullCartList.count != 0 {
                if indexPath.section == 0 {
                    
                    var singleAddCart = AddCart()
                    print("indexpath row \(indexPath.row)")
                    singleAddCart = fullCartList[indexPath.row]
                    let varients = singleAddCart.strVarients
                    let product = productForCart[singleAddCart.strProductId!]
                    let singleVarientsKey = Int((varients.first?.key)!)
                    let SingleVarientValue = varients.first?.value as! String
                    
                    var productVarient = ProductVarient()
                    productVarient = (product?.strProductVarients[singleVarientsKey!])!
                   // if cell.imgProduct.image == nil {
                        let imgurl = product?.strProductimage.first?.value as! String
                        let imgURL = URL(string: imgurl)
                        
                        cell.imgProduct.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
                        cell.imgProduct.layer.borderWidth = 1
                        cell.imgProduct.layer.cornerRadius = 3
                        DispatchQueue.global().async {
                            let data = try? Data(contentsOf: imgURL!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                            DispatchQueue.main.async {
                                cell.imgProduct.image = UIImage(data: data!)
                            }
                        }
                    //}
                    cell.lblBrandName.text = product?.strProductbrand
                    cell.lblProductTitle.text = product?.strProductName
                    
                    cell.btnVarient.setTitle(productVarient.strUnit, for: .normal)
                    cell.lblProductQntyCount.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
                    cell.lblProductQntyCount.layer.borderWidth = 1
                    cell.lblProductQntyCount.layer.cornerRadius = 4
                    cell.lblProductQntyCount.text = SingleVarientValue
                    let perProductTotalPrice = productVarient.strRegularPrice! * Float(SingleVarientValue)!
                    dicSelectedProductTolPrice[indexPath.row] = perProductTotalPrice
                    cell.lblPrice.text = String(perProductTotalPrice)
                    cell.btnVarientIncrease.tag = indexPath.row
                    cell.btnVarientIncrease.addTarget(self, action: #selector(varientCountIncrease(sender:)), for: .touchUpInside)
                    selectedVarientKey = singleVarientsKey
                    selectedQuantity = Int(cell.lblProductQntyCount.text!)
                    cell.btnVarientDecrease.tag = indexPath.row
                    cell.btnVarientDecrease.addTarget(self, action: #selector(varientCountDecrease(sender:)), for: .touchUpInside)
                    
                    return cell
                }else if indexPath.section == 1  {
                    checkOutTotalPrice()
                    let fee = deliveryfeeArr["fee"] as! Float
                    let to = deliveryfeeArr["to"] as! Float
                    if totalCheckOutPrice >= to {
                        cellCheckout.lblDeliveryFee.isHidden = true
                        cellCheckout.lblOrderEligible.text = "Your order eligible for free shipping"
                    }else {
                        cellCheckout.lblDeliveryFee.isHidden = false
                        cellCheckout.lblDeliveryFee.text = "$ \(fee) Delivery fee applies"
                        let remining = to - totalCheckOutPrice
                         cellCheckout.lblOrderEligible.text = "Add $ \(remining) for Free 2 hour delivery"
                    }
                    cellCheckout.btnCheckOut.setTitle( "CHECKOUT - $ \(totalCheckOutPrice)", for: .normal)
                    return cellCheckout
                }
            }
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
