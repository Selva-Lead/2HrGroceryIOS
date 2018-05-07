//
//  FireAuthModel.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 07/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit

class FireAuthModel: NSObject {

    func saveCards(CustomerId: String, Token: String) {
        FIRUtils.saveCardDBRef(customerId: CustomerId, uid: Token).setValue(saveCard.self)
    }
}
