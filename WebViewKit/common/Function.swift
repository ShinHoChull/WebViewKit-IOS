//
//  Function.swift
//  WebViewKit
//
//  Created by YongChul Shin on 2022/01/11.
//

import Foundation
import UIKit

func versionCheck() -> Int {
    
    let versionName : String = UIDevice.current.name
    let names = versionName.split(separator: " ")
    var versionCodeStr = ""
    if names.count > 1 {
        versionCodeStr = String(names[1])
    }
    
    var version = 0
    
    if versionCodeStr != "" {
        version = Int(versionCodeStr) ?? 0
    }
    
    return version
}
