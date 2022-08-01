//
//  AlbumView+DataSource.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import UIKit

extension AlbumView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.state {
        case .loading:
            return collectionView.reuse(LoadingCollectionViewCell.self, indexPath)
        case .error:
            let cell = collectionView.reuse(ErrorCollectionViewCell.self, indexPath)
            cell.onRetry = { [weak self] in
                self?.viewModel.getAlbums()
            }
            return cell
        case .data:
            let cell = collectionView.reuse(AlbumCollectionViewCell.self, indexPath)
            cell.imageUrl = viewModel.getImage(for: indexPath.row)
            return cell
        }
    }
}
