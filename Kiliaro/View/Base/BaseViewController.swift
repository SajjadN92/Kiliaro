//
//  BaseViewController.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 7/14/22.
//

import UIKit

class BaseViewController: UIViewController {
    var theme = ThemeManager.currentTheme
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViewController()
        addSubviews()
        setupConstraints()
    }
    
    func configViewController() {
        view.backgroundColor = theme.backgroundColor
    }
    
    func addSubviews() { }
    func setupConstraints() { }
}
