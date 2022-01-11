//
//  MainVC.swift
//  WebViewKit
//
//  Created by YongChul Shin on 2022/01/10.
//

import Foundation
import UIKit
import WebKit

class MainVC : UIViewController ,  WKUIDelegate , WKNavigationDelegate, WKDownloadDelegate{
  
    
    
    var progressView : UIProgressView!
    var webview : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        view.backgroundColor = .white
        setUpProgressView()
        setUpWebKit()
        
    }
    
    /**
     Wewview progressView Controller
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            
            progressView.isHidden = false
            progressView.progress = Float(webview.estimatedProgress)
            
            if webview.estimatedProgress >= 1 {
                progressView.isHidden = true
            }
        }
    }
    
    func setUpProgressView() {
        progressView = UIProgressView()
        view.addSubview(progressView)
        
        progressView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Defines.TOP_SAFE_AREA_MARGIN)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(3)
        }
        
        progressView.tintColor = UIColor.yellow
    }
    
    func setUpWebKit() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences = WKPreferences()
        webConfiguration.userContentController = WKUserContentController()
        webConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = true;
        webConfiguration.preferences.javaScriptEnabled = true
        
        webview = WKWebView(frame: .zero, configuration: webConfiguration)
        webview.uiDelegate = self
        webview.navigationDelegate = self
        
        view.addSubview(webview)
        
        //add observer to get estimated progress value
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        self.setUpWebViewSetting(webview: webview)
        
        webview.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom)
            $0.bottom.equalToSuperview().offset(-Defines.BOTTOM_SAFE_AREA_MARGIN)
            $0.leading.trailing.equalToSuperview()
        }
        
        let url = URL(string: Defines.baseUrl)
        if url != nil {
            let requestUrl = URLRequest(url: url!)
            webview.load(requestUrl)
        }
    }
    
    func setUpWebViewSetting(webview : WKWebView) {
        // * WKWebView 화면 비율 맞춤 설정
        webview.evaluateJavaScript("navigator.userAgent") { ( result , error )  in
            let originUserAgent = result as! String
            let agent = originUserAgent + " APP_IOS"
            webview.customUserAgent = agent
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        Defines.log(logName: "url-> \(navigationAction.request.url)")
        
        if let url = navigationAction.request.url, url.scheme != "http" && url.scheme != "https" {
                UIApplication.shared.openURL(url)
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }

//        let urlString = navigationAction.request.url?.absoluteString ?? ""
//        print("decidePolicyFor navigationAction: \(urlString)")
//
//        decisionHandler(.allow)
    }
    
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        Defines.log(logName: "newCratePopUrl -> \(webView.url!)")

        let popWebView = WKWebView(frame: .zero,configuration: configuration)
        popWebView.uiDelegate = self
        popWebView.navigationDelegate = self
        self.webview.addSubview(popWebView)

        popWebView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        popWebView.load(navigationAction.request)
        
//        if navigationAction.targetFrame?.isMainFrame == nil {
//            webView.load(navigationAction.request)
//        }

        return popWebView
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
    
    
    
    
    func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {
        download.delegate = self
    }


    func download(_ download: WKDownload, decideDestinationUsing response: URLResponse, suggestedFilename: String, completionHandler: @escaping (URL?) -> Void) {
        
       
    }
    
    func download(_ download: WKDownload, decideDestinationUsing response: URLResponse, suggestedFilename: String) async -> URL? {
        
    }
    
    
}
