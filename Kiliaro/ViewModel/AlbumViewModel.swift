//
//  AlbumViewModel.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import UIKit

class AlbumViewModel: ViewModel {
    var useCase: AlbumUseCaseable
    var album: String
    var onReload: (() -> Void)?
    
    private var items = [Media]()
    
    init(album: String, useCase: AlbumUseCaseable = AlbumUseCase()) {
        self.album = album
        self.useCase = useCase
    }
    
    func getAlbums() {
        Task { @MainActor in
            self.items = try! await useCase.getMedia(for: album)
            self.onReload?()
        }
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func getImageSize(for indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - getMinimuminterItemSpacing() - getInsetForSection().left - getInsetForSection().right) / 2
        let item = items[indexPath.row]
        let targetHeight = item.resx * width / item.resy
        
        return CGSize(width: width, height: targetHeight)
    }
    
    func getMinimumLineSpacing() -> CGFloat {
        return 8
    }
    
    func getMinimuminterItemSpacing() -> CGFloat {
        return 8
    }
    
    func getInsetForSection() -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
