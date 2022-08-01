//
//  AlbumDataStore.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import Foundation

protocol AlbumDataStoreable: BaseDataStore {
    var remote: AlbumRemoteable { get }
    var cache: AlbumCacheable { get }
}

class AlbumDataStore: AlbumDataStoreable {
    var remote: AlbumRemoteable
    var cache: AlbumCacheable
    
    init(remote: AlbumRemoteable = AlbumRemote(),
         cache: AlbumCacheable = AlbumCache()) {
        
        self.remote = remote
        self.cache = cache
    }
}
