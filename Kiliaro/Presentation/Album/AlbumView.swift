//
//  AlbumView.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import UIKit

class AlbumView: BaseViewController, View {
    
    var viewModel: AlbumViewModel!
    
    lazy var albumCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(AlbumCollectionViewCell.self)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getAlbums()
        viewModel.onReload = { [weak self] in
            self?.albumCollectionView.reloadData()
        }
    }
    
    override func addSubviews() {
        view.addSubview(albumCollectionView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            albumCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            albumCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            albumCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            albumCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func configViewController() {
        super.configViewController()
        title = viewModel.album
    }
}