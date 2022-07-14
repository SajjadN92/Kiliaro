//
//  BuildConfigs.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 7/14/22.
//

import Foundation

enum BuildConfigs {

    private static func getValue(for key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }

    static var baseUrl: String {
        return getValue(for: "BASE_URL") ?? ""
    }
    
}
