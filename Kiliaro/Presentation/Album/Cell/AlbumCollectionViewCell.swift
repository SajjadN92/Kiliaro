//
//  AlbumCollectionViewCell.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import UIKit
import Kingfisher

class AlbumCollectionViewCell: UICollectionViewCell {
    
    var imageUrl: URL! {
        didSet {
            imageView.kf.setImage(with: imageUrl) { [weak self] result in
                guard let self = self else {
                    return
                }
                
                let path = ImageCache.default.cachePath(forKey: self.imageUrl.absoluteString)
                guard let attribtues = try? FileManager.default.attributesOfItem(atPath: path),
                      let fileSize = attribtues[FileAttributeKey.size] as? Int else {
                    return
                }
                
                self.sizeLabel.isHidden = false
                self.sizeLabel.text = "\((Double(fileSize) / 1024 / 1024).rounded(toPlaces: 3)) MB"
            }
            
        }
    }
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        return iv
    }()
    
    lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = ThemeManager.currentTheme.buttonBgColor
        label.textColor = ThemeManager.currentTheme.buttonTextColor
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    func commonInit() {
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(sizeLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            sizeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sizeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            sizeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sizeLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    override func prepareForReuse() {
        sizeLabel.isHidden = true
    }
}
