//
//  AppDelegate.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 30/04/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import IQKeyboardManagerSwift
import Stripe

var useruid :String!
var emailpreference :String!
var smspreference :String!
var useruidstatus :String!
var UserEmailID :String!
var UserFirstName :String!
var UserLastName :String!
var UserDisplayName: String!
var UserMobileNumber :String!
var fullCartList:[AddCart] = [AddCart]()
var productForCart: [String:ProductForSale] = [String:ProductForSale]()
var productForSaleItems = [ProductDropDown]()
var deliveryfeeArr : [String: AnyObject] = [String:AnyObject]()
var customAddressList : [AddressList] = [AddressList]()
var availabilityTimes = NSArray()
var savedCards : [String:saveCard] = [String:saveCard]()
var savedCardsKey : [String] = [String]()
var totalCheckOutPrice: Float = 0
var selectedDateandTime: String?
var strCheckout: String?
var selectedCard: Int = 0
var strCompleted : String?
var strDeliveryDetails: [String:AnyObject] = [String:AnyObject]()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        //useruid = "RYr3lNznnpMQFcxcxSjrQbyqgoy1"
        FirebaseApp.configure()
        
        IQKeyboardManager.sharedManager().enable = true

        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
      
        useruid = ""
        UserEmailID = ""
        UserFirstName = ""
        UserLastName = ""
        UserMobileNumber = ""
        
        let UserDefault = UserDefaults.standard

        if useruid == ""
        {
            if UserDefault.value(forKey: "uid") != nil
            {
                useruid = UserDefault.value(forKey: "uid") as? String
                UserEmailID = UserDefault.value(forKey: "email") as? String
                UserFirstName = UserDefault.value(forKey: "firstName") as? String
                UserLastName = UserDefault.value(forKey: "lastName") as? String
                UserMobileNumber = UserDefault.value(forKey: "phone") as? String
            }
            else
            {
                print(useruid)
                print(UserEmailID)
                print(UserFirstName)
                print(UserLastName)
                print(UserMobileNumber)
            }
        }
       
         STPPaymentConfiguration.shared().publishableKey = "pk_test_ZhRZA8rzzTlnnrGRTCO0EphL"
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        
        return handled
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

