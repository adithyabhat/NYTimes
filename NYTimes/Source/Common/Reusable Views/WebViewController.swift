//
//  WebViewViewController.swift
//  NYTimes
//
//  Created by Adithya Bhat on 15/01/2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    //MARK: - Properties
    
    private var webView = WKWebView()
    private var navigationBarTitle: String
    private var url: String
    
    //MARK: - Init
    
    init(title: String, url: String) {
        self.navigationBarTitle = title
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        if let url = URL(string: self.url) {
            loadURL(url: url)
        }
    }

    //MARK: - Private methods
    
    private func setupView() {
        self.title = self.navigationBarTitle
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func loadURL(url: URL) {
        webView.load(URLRequest(url: url))
    }
}
