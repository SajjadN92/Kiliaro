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
    
    func getImage(for index: Int) -> URL {
        let url = items[index].thumbnail_url.appending("w", value: "\(Int(getImageSize(for: index).width))")
        return url
    }
    
    func getImageSize(for index: Int) -> CGSize {
        let width = (UIScreen.main.bounds.width -
                     AlbumCollectionViewLayout.inset.left -
                     AlbumCollectionViewLayout.inset.right -
                     AlbumCollectionViewLayout.verticalSpacing) / 2
        let item = items[index]
        let targetHeight = item.resx * width / item.resy
        
        return CGSize(width: width, height: targetHeight)
    }
}
