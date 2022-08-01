//
//  MediaViewModel.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/2/22.
//

import UIKit
import Kingfisher

class MediaViewModel: ViewModel {
    var onStateChange: ((ViewState) -> Void)?
    private var item: Media
    private(set) var state = ViewState.loading
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'Z'"
        guard let date = dateFormatter.date(from: item.created_at) else {
            return ""
        }
            
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    var imageUrl: URL {
        return item.download_url
    }
    
    init(media: Media) {
        item = media
    }
    
    private func changeState(to newState: ViewState) {
        state = newState
        onStateChange?(newState)
    }
    
    func setImage(on imageView: UIImageView) {
        changeState(to: .loading)
        imageView.kf.setImage(with: item.download_url) { [weak self] result in
            switch result {
            case .failure:
                self?.changeState(to: .error)
            case .success:
                self?.changeState(to: .data)
            }
        }
    }
}
