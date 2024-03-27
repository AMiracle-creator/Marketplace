//
//  WebViewerController.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 16.01.2024.
//

import UIKit
import WebKit

class WebViewerController: UIViewController {
    private let webView = WKWebView()
    private let url: String
    
    init(with url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        guard let url = URL(string: self.url) else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        self.webView.load(URLRequest(url: url))
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(didTapDone))
        self.navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        
        self.view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    //MARK: - Selectors
    @objc private func didTapDone() {
        self.dismiss(animated: true, completion: nil)
    }
}
