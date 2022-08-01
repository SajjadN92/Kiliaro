//
//  AlbumCache.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import Foundation

protocol AlbumCacheable: BaseCache {
    func getMedia(for album: String) async throws -> [Media]
}

class AlbumCache: AlbumCacheable {
    
    func getMedia(for album: String) async throws -> [Media] {
        return []
    }
    
}
