//
//  ProgressView.swift
//  DubizzleApp
//
//  Created by Vineet Sansare on 12/20/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import Foundation
import UIKit

/**
 A view that shows that a task is in progress.
 You control when an activity indicator animates by calling the showProgressViewNow() and hideProgressView() methods.
 */

open class ProgressView {
    static let sharedInstance = ProgressView()
    
    var containerView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    //MARK: Public Methods
    
    open func isProgressViewActive() -> Bool {
        return activityIndicator.isAnimating
    }
    
    open func showProgressViewNow() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let view = appDelegate.window!
        
        containerView.frame = view.frame
        containerView.center = view.center
        containerView.backgroundColor = AppConstants.TRANSLUCENT_COLOR
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .white
        activityIndicator.frame.origin.x = (containerView.frame.size.width - activityIndicator.frame.size.width)/2
        activityIndicator.frame.origin.y = (containerView.frame.size.height - activityIndicator.frame.size.height)/2
        
        containerView.addSubview(activityIndicator)
        
        let label:UILabel=UILabel(frame: CGRect(x: 10, y: activityIndicator.frame.origin.y + activityIndicator.frame.size.height + 10, width: containerView.frame.size.width - 20, height: 0))
        label.backgroundColor=UIColor.clear
        label.textColor=UIColor.black
        label.font=UIFont(name:AppConstants.HELVETICA_NEUE,size:CGFloat(20))
        label.text="Please wait..."
        label.numberOfLines=0
        label.sizeToFit()
        label.backgroundColor = UIColor.clear
        label.textColor = .white
        label.frame.origin.x = (containerView.frame.size.width - label.frame.size.width)/2
        containerView.addSubview(label)
        
        view.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    open func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

