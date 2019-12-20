//
//  AppConstants.swift
//  DubizzleApp
//
//  Created by Vineet Sansare on 12/20/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import Foundation
import UIKit

class AppConstants: NSObject {
    
    //MARK: System Info
    static let APP_VERSION:String=(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String);
    static let DEVICE_MODEL = UIDevice.current.model;
    static let DEVICE_SYSTEM_VERSION = UIDevice.current.systemVersion
    
    //MARK: Colors
    static let TRANSLUCENT_COLOR = UIColor(red:0.0/255.0,green:0.0/255.0,blue:0.0/255.0,alpha:0.8) // Translucent Color
    static let RED_COLOR = UIColor(red:235.0/255.0,green:84.0/255.0,blue:55.0/255.0,alpha:0.8) // Red Color
    
    //MARK: Fonts
    static let HELVETICA_NEUE = "HelveticaNeue"
    static let HELVETICA_NEUE_BOLD = "HelveticaNeue-Bold"
}
