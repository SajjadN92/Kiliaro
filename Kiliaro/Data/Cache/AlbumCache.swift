//
//  AlbumCache.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import Foundation

protocol AlbumCacheable: BaseCache {
    func getMedia(for album: String) async throws -> [Media]
    func save(media: [Media] ,for album: String) async throws
    func deleteAll() async throws
}

class AlbumCache: AlbumCacheable {
    
    let store: CoreDataStore<MediaEntity>
    
    init(store: CoreDataStore<MediaEntity> = CoreDataStore<MediaEntity>()) {
        self.store = store
    }
    
    func save(media: [Media], for album: String) async throws {
        try await store.save(items: media)
    }
    
    func getMedia(for album: String) async throws -> [Media] {
        return try await store.getItems().compactMap { Media.init(entity: $0) }
    }
    
    func deleteAll() async throws {
        try await store.removeAll()
    }
}
