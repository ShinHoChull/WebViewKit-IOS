//
//  SplashVC.swift
//  WebViewKit
//
//  Created by YongChul Shin on 2022/01/10.
//

import Foundation
import UIKit
import SnapKit

class SplashVC : UIViewController {
    
    var mTimer : Timer?
    var number : Int = 0
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        Defines.log(logName: "splash Go!")
        setUpView()
    }
    
    func setUpView() {
        mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCallBack), userInfo: nil, repeats: true)
        setUpSplashImage()
    }
    
    func setUpSplashImage() {
        let splash_image =  UIImageView()
        view.addSubview(splash_image)
        
        splash_image.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        splash_image.image = UIImage(named: "a.jpg")
        splash_image.contentMode = .scaleAspectFill
    }
    
    @objc
    func timerCallBack () {
        number += 1
        if number > 2 {
            mTimer?.invalidate()
            
            let vc = MainVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    
}
