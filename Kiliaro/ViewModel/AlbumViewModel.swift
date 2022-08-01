//
//  AlbumViewModel.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import UIKit

class AlbumViewModel: ViewModel {
    weak var coordinator: AppCoordinator?
    var useCase: AlbumUseCaseable
    var album: String
    var onReload: (() -> Void)?
    
    private var items = [Media]()
    private(set) var state = ViewState.loading
    
    init(album: String, useCase: AlbumUseCaseable = AlbumUseCase()) {
        self.album = album
        self.useCase = useCase
    }
    
    func getAlbums() {
        Task { @MainActor in
            self.changeState(to: .loading)
            do {
                self.items = try await useCase.getMedia(for: album)
                self.changeState(to: .data)
            } catch {
                self.changeState(to: .error)
            }
        }
    }
    
    func numberOfItems() -> Int {
        return state == .data ? items.count : 1
    }
    
    func getImage(for index: Int) -> URL {
        let url = items[index].thumbnail_url.appending("w", value: "\(Int(getImageSize(for: index).width))")
        return url
    }
    
    func getImageSize(for index: Int) -> CGSize {
        switch state {
        case .data:
            let width = (UIScreen.main.bounds.width -
                         AlbumCollectionViewLayout.inset.left -
                         AlbumCollectionViewLayout.inset.right -
                         (AlbumCollectionViewLayout.verticalSpacing * 2)) / 3
            let item = items[index]
            let targetHeight = item.resy * width / item.resx
            
            return CGSize(width: width, height: targetHeight)
        default:
            return CGSize(width: UIScreen.main.bounds.width, height: 250)
        }
        
    }
    
    private func changeState(to newState: ViewState) {
        state = newState
        onReload?()
    }
    
    func mediaTapped(at index: Int) {
        coordinator?.navigateToMedia(with: items[index])
    }
    
    func redoTapped() {
        changeState(to: .loading)
        getAlbums()
    }
}


enum ViewState {
    case loading
    case error
    case data
}
