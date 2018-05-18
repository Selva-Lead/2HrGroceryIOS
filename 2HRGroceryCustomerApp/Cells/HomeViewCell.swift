//
//  HomeViewCell.swift
//  2HRGroceryCustomerApp
//
//  Created by Sathiyan Sivaprakasam on 05/05/18.
//  Copyright © 2018 Sathiyan Sivaprakasam. All rights reserved.
//

import UIKit
import DropDown

class HomeViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var Innerview: UIView!
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var varientButton: UIButton!
    @IBOutlet weak var dropview: UIView!
    
   /* let varientdropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.varientdropDown
        ]
    }() */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      //  setupDropDowns()
        // Initialization code
        
    }

  /*  func setupDropDowns() {
       // setupChooseArticleDropDown()
      
    }
    
    func setupChooseArticleDropDown() {
        varientdropDown.anchorView = varientButton
        
        // Will set a custom with instead of anchor view width
        //        dropDown.width = 100
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        varientdropDown.bottomOffset = CGPoint(x: 0, y: varientButton.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        varientdropDown.dataSource = [
            "iPhone SE | Black | 64G",
            "Samsung S7",
            "Huawei P8 Lite Smartphone 4G",
            "Asus Zenfone Max 4G",
            "Apple Watwh | Sport Edition"
        ]
        
        // Action triggered on selection
        varientdropDown.selectionAction = { [weak self] (index, item) in
            self?.varientButton.setTitle(item, for: .normal)
        }
        
        varientdropDown.multiSelectionAction = { [weak self] (indices, items) in
            print("Muti selection action called with: \(items)")
            if items.isEmpty {
                self?.varientButton.setTitle("", for: .normal)
            }
        }
        
        // Action triggered on dropdown cancelation (hide)
        //        dropDown.cancelAction = { [unowned self] in
        //            // You could for example deselect the selected item
        //            self.dropDown.deselectRowAtIndexPath(self.dropDown.indexForSelectedRow)
        //            self.actionButton.setTitle("Canceled", forState: .Normal)
        //        }
        
        // You can manually select a row if needed
        //        dropDown.selectRowAtIndex(3)
    } */
}
