//
//  AlbumUseCase.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import Foundation

protocol AlbumUseCaseable: BaseUseCase {
    func getMedia(for album: String) async throws -> [Media]
}

class AlbumUseCase: AlbumUseCaseable {
    
    var repository: AlbumRepositoryable
    
    init(repository: AlbumRepositoryable = AlbumRepository()) {
        self.repository = repository
    }
    
    func getMedia(for album: String) async throws -> [Media] {
        do {
            return try await repository.getRemoteMedia(for: album)
        } catch {
            return try await repository.getCacheMedia(for: album)
        }
    }
    
}


