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
        let cell = collectionView.reuse(AlbumCollectionViewCell.self, indexPath)
        cell.imageUrl = viewModel.getImage(for: indexPath.row)
        return cell
    }
}
