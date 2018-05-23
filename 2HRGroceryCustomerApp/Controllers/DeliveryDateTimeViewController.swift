//
//  DeliveryDateTimeViewController.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 04/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

func getWeekday(weekday:Int) -> String {
    switch weekday {
    case 0:
        return "Sunday"
    case 1:
        return "Monday"
    case 2:
        return "Tuesday"
    case 3:
        return "Wednesday"
    case 4:
        return "Thursday"
    case 5:
        return "Friday"
    case 6:
        return "Saturday"
    default:
        return ""
    }
}

class DeliveryDateTimeViewController: UIViewController {


    struct addressList {
        struct name {
            static let identifier = "cellName"
        }
        struct address {
            static let identifier = "cellAddress"
        }
        struct dateAndTime {
            static let identifier = "cellDateAndTime"
        }
    }
    
   
     @ IBOutlet weak var deliTopView: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    var strmothdayArr : [String] = [String]()
    var dateAndTimeArray : [String] = [String]()
    var dateAndTimeWithYear : [String] = [String]()
    var imgChange : UIImage!
    var imgChangeTag: Int?
    var arrlistWithYear: [Date] = [Date]()
    
    override func viewDidLoad() {
       // UIImage.init(cgImage: #imageLiteral(resourceName: "uncheck.png") as! CGImage)
        super.viewDidLoad()
        imgChange = #imageLiteral(resourceName: "uncheck.png")
        deliTopView.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        deliTopView.layer.borderWidth = 0.5
        deliTopView.layer.shadowColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
        deliTopView.layer.shadowOffset = CGSize(width: 1, height: 2.0)
        deliTopView.layer.shadowOpacity = 1.0
        deliTopView.layer.shadowRadius = 10.0
        let nib = UINib(nibName: "View", bundle: nil)
        self.tblView.register(nib, forHeaderFooterViewReuseIdentifier: "PaymentHeader")
        if deliveryOption == 1 {
          deliveryToDelivery()
        }
    }
    
    func deliveryToDelivery() {
        var calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier(rawValue: NSGregorianCalendar))
        let dateComponent = NSDateComponents()
        let currentDate = getCurrentDate()
        for i in 1...7 {
            dateComponent.day = i
            let newDate = calendar?.date(byAdding: dateComponent as DateComponents, to: currentDate, options:[])
            let day = Calendar.current.component(.day, from: newDate!)
            let month = Calendar.current.component(.month, from: newDate!)
            let singleMonthDay = "\(month)/ \(day)"
            strmothdayArr.append(singleMonthDay)
            arrlistWithYear.append(newDate!)
            print(newDate)
        }
        
        
        
        let weekday = Calendar.current.component(.weekday, from: Date())
        var intWeakday: Int = weekday - 1
        var intcount = 0
        for availabilityTime in availabilityTimes {
            let vv = availabilityTime as! [String:AnyObject]
            for v in vv {
                if v.value != nil {
                    if  let sv = v.value as? NSArray {
                        for (key,value)in sv.enumerated() {
                            let va = value as! [String:AnyObject]
                            //print (sv.value(forKey: "startHour"))
                            //  print (sv.value(forKey: "endHour"))
                            // print("\(key) and \(value)")
                            let weeday = getWeekday(weekday: intWeakday)
                            let str = "-"
                            let startDate = va["startHour"] as! Int
                            let strStartDteinNormalTime =  normalTimeArr[startDate]
                            let endDate = va["endHour"] as! Int
                            let strEndDteNormalTime = normalTimeArr[endDate]
                            let strfull = "\(strmothdayArr[intcount]) \(weeday) \(strStartDteinNormalTime) \(str) \(strEndDteNormalTime)"
                            let strYearfull = "\(arrlistWithYear[intcount]) \(weeday) \(startDate) \(str) \(endDate)"
                            dateAndTimeArray.append(strfull)
                            dateAndTimeWithYear.append(strYearfull)
                            print("\(strmothdayArr[intcount]) \(weeday) \(startDate) \(str) \(endDate)")
                        }
                    }
                }
            }
            if intWeakday == 6 {
                intWeakday = 0
            }else {
                intWeakday += 1
            }
            intcount = intcount + 1
        }
    }
    
    func getCurrentDate()-> Date {
        let nowcu = Date()
        let dateFormattercurr = DateFormatter()
        dateFormattercurr.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let nameOfMonth = dateFormattercurr.string(from: nowcu)
        let isoDate = nameOfMonth//"2018-12-29T10:44:00+0000"
        
        
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        
        var now = dateFormatter.date(from: isoDate)
        
        
        
        var nowComponents = DateComponents()
        
        let calendar = Calendar.current
        
        nowComponents.year = Calendar.current.component(.year, from: now!)
        
        nowComponents.month = Calendar.current.component(.month, from: now!)
        
        nowComponents.day = Calendar.current.component(.day, from: now!)
        
        // nowComponents.hour = Calendar.current.component(.hour, from: now)
        
        //nowComponents.minute = Calendar.current.component(.minute, from: now)
        
        // nowComponents.second = Calendar.current.component(.second, from: now)
        
        // nowComponents.timeZone = NSTimeZone.local
       
        now = calendar.date(from: nowComponents)!
        
        return now as! Date
        
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func addressChange(sender: UIButton) {
        print("action calling")
    }
    @objc func dateTimeCheckout(sender: UIButton) {
        imgChangeTag = sender.tag
        if sender.imageView?.image == #imageLiteral(resourceName: "uncheck.png") {
            imgChange = #imageLiteral(resourceName: "check.png")
            //UserDefaults.standard.set(dateAndTimeArray[sender.tag], forKey: "DeliveryDateAndTime")
            selectedDateandTime = dateAndTimeArray[sender.tag]
            seleDateWithYear = dateAndTimeWithYear[sender.tag]
        }else {
            imgChange = #imageLiteral(resourceName: "uncheck.png")
        }
        tblView.reloadData()
    }
    @IBAction func ContinuePayment(_ sender: UIButton) {
        //let dayAndTime = UserDefaults.standard.object(forKey: "DeliveryDateAndTime") as? String
        if selectedDateandTime != nil {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentDetailsViewController") as! PaymentDetailsViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }else {
            toasterView()
        }
      
    }
    @objc func toasterView() {
        let message = "select delivery date and time."
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.frame.size = CGSize(width: 250, height: 100)
        alert.view.tintColor = UIColor.white
        self.present(alert, animated: true)
        
        // duration in seconds
        let duration: Double = 0.2
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true)
        }
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
extension DeliveryDateTimeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PaymentHeader") as! PaymentHeader
        if section == 0  {
            cell.btnChange.isHidden = true
            cell.lblTitle.text = "CUSTOMER NAME"
        }else if section == 1 {
            if deliveryOption == 1 {
                cell.btnChange.isHidden = false
            }else {
                cell.btnChange.isHidden = true
            }
            cell.btnChange.addTarget(self, action: #selector(addressChange(sender:)), for: .touchUpInside)
            cell.lblTitle.text = "DELIVERY ADDRESS"
        }else {
            cell.btnChange.isHidden = true
            cell.lblTitle.text = "DELIVERY DATE& TIME"
        }
        return cell
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        if section == 0 {
//            return "CUSTOMER NAME"
//        } else if section == 1 {
//            return "DELIVERY ADDRESS"
//        } else  {
//            return "Delivery Date & Time"
//        }
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if section == 2 {
            return dateAndTimeArray.count
        }
        return 1
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 72
        }else if indexPath.section == 1 {
            return 121
        }else {
            return 37
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: addressList
            .name.identifier) as! AddressListTableViewCell
        let celldetail = tableView.dequeueReusableCell(withIdentifier: addressList.address.identifier) as! AddressListTableViewCell
        let cellDateAndTime = tableView.dequeueReusableCell(withIdentifier: addressList.dateAndTime.identifier) as! AddressListTableViewCell
        cell.selectionStyle = .none
        celldetail.selectionStyle = .none
        cellDateAndTime.selectionStyle = .none
        if indexPath.section == 0 {
            cell.addrName.text = UserFirstName
            return cell
        }else if indexPath.section == 1 {
            celldetail.lbladdrDetail.layer.borderColor = UIColor(red:0.112, green:0.112, blue:0.112, alpha:0.21).cgColor
            celldetail.lbladdrDetail.layer.borderWidth = 1.0
            celldetail.lbladdrDetail.text = customAddressList[0].strFullAddress
            return celldetail
        }else if indexPath.section == 2 {
            cellDateAndTime.lblTotalDateandTimeList.text = dateAndTimeArray[indexPath.row]
            cellDateAndTime.vewDateAndTime.layer.borderWidth = 1.0
            cellDateAndTime.vewDateAndTime.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0).cgColor
            if imgChangeTag == indexPath.row {
                cellDateAndTime.btnDeliveryTimeCheck.setImage(imgChange, for: .normal)
            }else {
                cellDateAndTime.btnDeliveryTimeCheck.setImage(#imageLiteral(resourceName: "uncheck.png"), for: .normal)
               // UserDefaults.standard.set(nil, forKey: "DeliveryDateAndTime")
            }
            cellDateAndTime.btnDeliveryTimeCheck.tag = indexPath.row
            cellDateAndTime.btnDeliveryTimeCheck.addTarget(self, action: #selector(dateTimeCheckout(sender:)), for: .touchUpInside)
            return cellDateAndTime
        }
        return AddressListTableViewCell()
    }
    
    
}
