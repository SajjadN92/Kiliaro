//
//  ErrorCollectionViewCell.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/2/22.
//

import UIKit

class ErrorCollectionViewCell: UICollectionViewCell {
    
    var onRetry: (() -> Void)?
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ThemeManager.currentTheme.textColor
        label.text = "general_error".localized
        return label
    }()
    
    lazy var retryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ThemeManager.currentTheme.buttonBgColor
        button.setTitleColor(ThemeManager.currentTheme.buttonTextColor, for: .normal)
        button.setTitle("retry".localized, for: .normal)
        button.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    func commonInit() {
        contentView.addSubview(errorLabel)
        contentView.addSubview(retryButton)
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            retryButton.centerXAnchor.constraint(equalTo: errorLabel.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 15),
            retryButton.heightAnchor.constraint(equalToConstant: 40),
            retryButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func retryAction() {
        onRetry?()
    }
}
