//
//  AlbumViewModel.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import Foundation

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
}
