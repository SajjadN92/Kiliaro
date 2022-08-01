//
//  AlbumView+Delegate.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import UIKit

extension AlbumView: UICollectionViewDelegate, CustomLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    func sizeFor(index: Int) -> CGSize {
        return viewModel.getImageSize(for: index)
    }
}
