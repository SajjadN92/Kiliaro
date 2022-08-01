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
              let collectionView = collectionView else {
            return
        }
        
        size = collectionView.frame.size
        contentSize = .zero
        cache.removeAll()
        
        var firstColumn: CGFloat = 0
        var secondColumn: CGFloat = 0
        var thirdColumn: CGFloat = 0
        
        contentSize.width = collectionView.frame.width
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        
        for index in 0 ..< numberOfItems {
            let itemSize = layoutDelegate.sizeFor(index: index)
            var frame = CGRect.zero
            frame.size = itemSize

            if firstColumn <= secondColumn && firstColumn <= thirdColumn {
                frame.origin.x = AlbumCollectionViewLayout.inset.left
                frame.origin.y = firstColumn + AlbumCollectionViewLayout.verticalSpacing
                firstColumn += itemSize.height + AlbumCollectionViewLayout.verticalSpacing
            } else if secondColumn <= firstColumn && secondColumn <= thirdColumn {
                frame.origin.x = AlbumCollectionViewLayout.inset.left + AlbumCollectionViewLayout.horizontalSpacing + itemSize.width
                frame.origin.y = secondColumn + AlbumCollectionViewLayout.verticalSpacing
                secondColumn += itemSize.height + AlbumCollectionViewLayout.verticalSpacing
            } else {
                frame.origin.x = AlbumCollectionViewLayout.inset.left + (AlbumCollectionViewLayout.horizontalSpacing + itemSize.width) * 2
                frame.origin.y = thirdColumn + AlbumCollectionViewLayout.verticalSpacing
                thirdColumn += itemSize.height + AlbumCollectionViewLayout.verticalSpacing
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
