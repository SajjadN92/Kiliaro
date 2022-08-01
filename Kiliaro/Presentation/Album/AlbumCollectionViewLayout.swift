//
//  AlbumCollectionViewLayout.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import UIKit

class AlbumCollectionViewLayout: UICollectionViewFlowLayout {
    var layoutDelegate : CustomLayoutDelegate?
    
    static let inset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    static let verticalSpacing: CGFloat  = 8
    static let horizontalSpacing: CGFloat = 8
    private var contentSize = CGSize.zero
    private var size = CGSize.zero
    private var cache = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        guard let layoutDelegate = layoutDelegate,
              let collectionView = collectionView,
              cache.isEmpty else {
            return
        }
        
        size = collectionView.frame.size
        contentSize = .zero
        cache.removeAll()
        
        var leftY: CGFloat = 0
        var rightY: CGFloat = 0
        
        contentSize.width = collectionView.frame.width
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        
        for index in 0 ..< numberOfItems {
            let itemSize = layoutDelegate.sizeFor(index: index)
            var frame = CGRect.zero
            frame.size = itemSize

            if leftY <= rightY {
                frame.origin.x = AlbumCollectionViewLayout.inset.left
                frame.origin.y = leftY + AlbumCollectionViewLayout.verticalSpacing
                leftY += itemSize.height + AlbumCollectionViewLayout.verticalSpacing
            } else {
                frame.origin.x = AlbumCollectionViewLayout.inset.left + AlbumCollectionViewLayout.horizontalSpacing + itemSize.width
                frame.origin.y = rightY + AlbumCollectionViewLayout.verticalSpacing
                rightY += itemSize.height + AlbumCollectionViewLayout.verticalSpacing
            }
            
            contentSize.height = max(frame.maxY + AlbumCollectionViewLayout.inset.bottom , contentSize.height)
            
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }
    
    override var collectionViewContentSize: CGSize{
        return contentSize
    }
}

protocol CustomLayoutDelegate {
    func sizeFor(index : Int) -> CGSize
}
