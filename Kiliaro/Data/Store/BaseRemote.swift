//
//  Remoteable.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import Foundation

protocol BaseRemote {
    func decode<T: Decodable>(data: Data,decoder: JSONDecoder) throws -> T
}

extension BaseRemote {
    func decode<T: Decodable>(data: Data,decoder: JSONDecoder = JSONDecoder()) throws -> T {
        return try decoder.decode(T.self, from: data)
    }
}
