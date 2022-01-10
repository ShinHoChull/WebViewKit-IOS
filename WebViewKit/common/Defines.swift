//
//  Defines.swift
//  WebViewKit
//
//  Created by YongChul Shin on 2022/01/10.
//

import Foundation

class Defines {
    
    static let baseUrl = "https://m.naver.com/"
    
    static let MAIN_VIEW = MainVC()
    
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

