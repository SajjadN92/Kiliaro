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
}
