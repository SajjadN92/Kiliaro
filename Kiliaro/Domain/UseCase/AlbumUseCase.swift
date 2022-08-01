//
//  AlbumUseCase.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import Foundation

protocol AlbumUseCaseable: BaseUseCase {
    func getMedia(for album: String) async throws -> [Media]
    func invalidateCacheAndGetMedia(for album: String) async throws -> [Media]
}

class AlbumUseCase: AlbumUseCaseable {
    
    var repository: AlbumRepositoryable
    
    init(repository: AlbumRepositoryable = AlbumRepository()) {
        self.repository = repository
    }
    
    func getMedia(for album: String) async throws -> [Media] {
        do {
            let remoteMedia = try await repository.getRemoteMedia(for: album)
            try? await repository.deleteCache()
            try? await repository.save(media: remoteMedia, for: album)
            return remoteMedia
        } catch {
            let cacheMedia = try await repository.getCacheMedia(for: album)
            if cacheMedia.isEmpty {
                throw CacheError.fetchError
            } else {
                return cacheMedia
            }
        }
    }
    
    func invalidateCacheAndGetMedia(for album: String) async throws -> [Media] {
        try? await repository.deleteCache()
        return try await getMedia(for: album)
    }
}



