//
//  AlbumRepository.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import Foundation

protocol AlbumRepositoryable: BaseRepository {
    var dataFactory: AlbumDataStoreable { get }
    
    func getCacheMedia(for album: String) async throws -> [Media]
    func getRemoteMedia(for album: String) async throws -> [Media]
}

class AlbumRepository: AlbumRepositoryable {
    var dataFactory: AlbumDataStoreable
    
    init(dataFactory: AlbumDataStoreable = AlbumDataStore()) {
        self.dataFactory = dataFactory
    }
    
    func getCacheMedia(for album: String) async throws -> [Media] {
        return try await dataFactory.cache.getMedia(for: album)
    }
    
    func getRemoteMedia(for album: String) async throws -> [Media] {
        return try await dataFactory.remote.getMedia(for: album)
    }
}
