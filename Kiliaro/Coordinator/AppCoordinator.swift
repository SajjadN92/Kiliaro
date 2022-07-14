//
//  AppCoordinator.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 7/14/22.
//

import UIKit

class AppCoordinator: Coordinator {
    var childs: [Coordinator] = []
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let viewModel = ShareListViewModel()
        let shareList = ShareListView(viewModel: viewModel)
        let navigation = BaseNavigation(rootViewController: shareList)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    
}
