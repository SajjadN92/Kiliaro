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
        let layout = AlbumCollectionViewLayout()
        layout.layoutDelegate = self
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(AlbumCollectionViewCell.self)
        cv.register(ErrorCollectionViewCell.self)
        cv.register(LoadingCollectionViewCell.self)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    lazy var redoButton: UIBarButtonItem = {
        let button = UIBarButtonItem(systemItem: .refresh)
        button.target = self
        button.action = #selector(redoTapped)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onReload = { [weak self] in
            self?.albumCollectionView.reloadData()
        }
        viewModel.getAlbums()
    }
    
    override func addSubviews() {
        view.addSubview(albumCollectionView)
        navigationItem.rightBarButtonItem = redoButton
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
    
    @objc private func redoTapped() {
        viewModel.redoTapped()
    }
}
