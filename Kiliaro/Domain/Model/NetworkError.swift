//
//  NetworkError.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case noNetwork
    case decodeError
    case general
}
