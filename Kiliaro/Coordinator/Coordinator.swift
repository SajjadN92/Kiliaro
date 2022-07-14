//
//  Coordinator.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 7/14/22.
//

import Foundation

protocol Coordinator: AnyObject {
    var childs: [Coordinator] { get set }
    
    func add(child: Coordinator)
    func remove(child: Coordinator)
    func start()
}

extension Coordinator {
    func add(child: Coordinator) {
        childs.append(child)
    }
    
    func remove(child: Coordinator) {
        childs.removeAll(where: { $0 === child })
    }
}
