//
//  Activityloader.swift
//  Formpageswift
//
//  Created by Refulgence on 20/02/18.
//  Copyright © 2018 Refulgence. All rights reserved.
//

import Foundation
import UIKit

class ProgressHUD: UIVisualEffectView {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .dark)
    let vibrancyView: UIVisualEffectView

    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        contentView.addSubview(vibrancyView)
        contentView.addSubview(activityIndictor)
        contentView.addSubview(label)
        contentView.isUserInteractionEnabled = false
      //  contentView.backgroundColor=UIColor.black
        activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.frame.size.width / 4
            let height: CGFloat = 90.0
            self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2 ,
                                y: superview.frame.height / 2 - height / 2,
                                width: width,
                                height: height)
            vibrancyView.frame = self.bounds
            vibrancyView.backgroundColor=self.uicolorFromHex(rgbValue: 0xE6E6E6)
                //UIColor(white: 1, alpha: 0.7)
                //UIColor(white: 0.9, alpha: 0.7)
          //  vibrancyView.layer.cornerRadius=6.0
            
            let activityIndicatorSize: CGFloat = 200
            activityIndictor.frame = CGRect(x: vibrancyView.frame.size.width / 4,
                                            y: 20,
                                            width: vibrancyView.frame.size.width / 2,
                                            height: vibrancyView.frame.size.width / 4)
             self.activityIndictor.color = UIColor.black

            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            
            label.text = text
            label.textAlignment = NSTextAlignment.center
            label.frame = CGRect(x: vibrancyView.frame.size.width / 4 - 30,
                                 y: 45,
                                 width:120,
                                 height: 40)
            label.textColor = UIColor.black
            label.font = UIFont.boldSystemFont(ofSize: 16)
 
        }
    }
    func uicolorFromHex(rgbValue:UInt32)->UIColor
    {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    func show()
    {
        DispatchQueue.main.async
        {
            self.isHidden = false
        }
    }
    
    func hide() {
        DispatchQueue.main.async
        {
            self.isHidden = true
        }
    }
}
