//
//  Defines.swift
//  WebViewKit
//
//  Created by YongChul Shin on 2022/01/10.
//

import Foundation
import UIKit

class Defines {
    
    static let baseUrl = "https://m.naver.com/"
    static let MAIN_VIEW = MainVC()
    
    static var TOP_SAFE_AREA_MARGIN : CGFloat {
        get {
            if versionCheck() <= 8 {
                return 22.0
            }
            return 44.0
        }
    }

    static var BOTTOM_SAFE_AREA_MARGIN : CGFloat  {
        get {
            if versionCheck() <= 8 {
                return 49.0
            }
            return 83.0
        }
    }
    
    static func log(logName : String = "YONG") {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let current_date_string = formatter.string(from: Date())
        
        print("================")
        print(logName)
        print(current_date_string)
        print("================")
        
    }

    
    
}

