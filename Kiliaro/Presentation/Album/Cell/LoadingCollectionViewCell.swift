//
//  LoadingCollectionViewCell.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/2/22.
//

import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.startAnimating()
        activityView.color = ThemeManager.currentTheme.textColor
        return activityView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    func commonInit() {
        contentView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
