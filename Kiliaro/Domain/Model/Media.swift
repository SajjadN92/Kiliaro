//
//  Media.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 7/14/22.
//

import Foundation

struct Media: Decodable {
    let id: String
    let thumbnail_url: URL
    let download_url: URL
    let resx: Double
    let resy: Double
    let created_at: String
    
    init(entity: MediaEntity) {
        self.id = entity.id!
        self.thumbnail_url = URL(string: entity.thumbnail_url!)!
        self.download_url = URL(string: entity.download_url!)!
        self.resx = entity.resx
        self.resy = entity.resy
        self.created_at = entity.created_at!
    }
    
    init(id: String, thumbnail_url: URL, download_url: URL, resx: Double, resy: Double, created_at: String) {
        self.id = id
        self.thumbnail_url = thumbnail_url
        self.download_url = download_url
        self.resx = resx
        self.resy = resy
        self.created_at = created_at
    }
}
