//
//  AlbumRemote.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import Foundation

protocol AlbumRemoteable: BaseRemote {
    func getMedia(for album: String) async throws -> [Media]
}

class AlbumRemote: AlbumRemoteable {
    
    func getMedia(for album: String) async throws -> [Media] {
        guard let url = URL(string: getAlbumUrlString(for: album)) else {
            throw NetworkError.urlError
        }
        
        let response = try await URLSession.shared.data(from: url)
        
        guard let media: [Media] = try? decode(data: response.0) else {
            throw NetworkError.decodeError
        }
        
        return media
    }
    
    private func getAlbumUrlString(for album: String) -> String {
        return BuildConfigs.baseUrl + "shared/\(album)/media"
    }
    
}

