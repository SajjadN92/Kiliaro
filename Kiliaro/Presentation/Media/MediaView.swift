//
//  MediaView.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/2/22.
//

import UIKit

class MediaView: BaseViewController, View {
    
    var viewModel: MediaViewModel!
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var loadingProgress: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = ThemeManager.currentTheme.textColor
        indicator.startAnimating()
        return indicator
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "general_error".localized
        label.textColor = ThemeManager.currentTheme.textColor
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onStateChange = { [weak self] state in
            self?.errorLabel.isHidden = state != .error
            self?.retryButton.isHidden = state != .error
            self?.loadingProgress.isHidden = state != .loading
            self?.imageView.isHidden = state != .data
        }
        
        viewModel.setImage(on: imageView)
    }
    
    override func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(loadingProgress)
        view.addSubview(errorLabel)
        view.addSubview(retryButton)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            retryButton.centerXAnchor.constraint(equalTo: errorLabel.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 15),
            retryButton.heightAnchor.constraint(equalToConstant: 40),
            retryButton.widthAnchor.constraint(equalToConstant: 100),
            
            loadingProgress.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingProgress.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func configViewController() {
        super.configViewController()
        
        title = viewModel.date
    }
    
    @objc private func retryAction() {
        viewModel.setImage(on: imageView)
    }
}

