//
//  MainVC.swift
//  WebViewKit
//
//  Created by YongChul Shin on 2022/01/10.
//

import Foundation
import UIKit
import WebKit

class MainVC : UIViewController ,  WKUIDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        view.backgroundColor = .white
        setUpWebKit()
    }
    
    func setUpWebKit() {
        let webConfiguration = WKWebViewConfiguration()
        let webview = WKWebView(frame: .zero, configuration: webConfiguration)
        webview.uiDelegate = self
        view.addSubview(webview)
        
        setUpWebViewSetting(webview: webview)
        
        webview.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        let url = URL(string: Defines.baseUrl)
        if url != nil {
            let requestUrl = URLRequest(url: url!)
            webview.load(requestUrl)
        }
    }
    
    func setUpWebViewSetting(webview : WKWebView) {
        // * WKWebView 화면 비율 맞춤 설정
        
        
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if navigationAction.targetFrame?.isMainFrame == nil {
            webView.load(navigationAction.request)
        }

        return nil
    }
    
    // * WKWebView JavaScript alert 함수 호출 시 호출 이벤트를 수신하는 함수

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo,  completionHandler: @escaping () -> Void) {
       // * 전달 받은 message로 팝업 제목에 도메인 주소가 보이지 않도록 UIAlertController를 앱에서 호출하는 부분입니다.
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let ac = UIAlertAction(title: "OK", style: .default, handler: { action in
            completionHandler()
        })

       // * 만약 버튼의 색을 변경하고 싶다면 아래 구문을 추가 합니다.
        ac.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(ac)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // * WKWebView JavaScript confirm 함수 호출 시 호출 이벤트를 수신하는 함수
   func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {

       // * 전달 받은 message로 팝업 제목에 도메인 주소가 보이지 않도록 UIAlertController를 앱에서 호출하는 부분입니다.
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let ac = UIAlertAction(title: "OK", style: .default, handler: { action in
            completionHandler(true)
        })

        ac.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(ac)
       
        let ac2 = UIAlertAction(title: "NO", style: .cancel, handler: { action in
            completionHandler(false)
        })
        ac2.setValue(UIColor.darkGray, forKey: "titleTextColor")
        alertController.addAction(ac2)
        self.present(alertController, animated: true, completion: nil)
    }
    


    
    
    
}
