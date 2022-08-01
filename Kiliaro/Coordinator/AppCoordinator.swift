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
    var navigation: BaseNavigation?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let viewModel = ShareListViewModel()
        viewModel.coordinator = self
        let shareList = ShareListView(viewModel: viewModel)
        navigation = BaseNavigation(rootViewController: shareList)
        window?.rootViewController = navigation!
        window?.makeKeyAndVisible()
    }
    
    func navigateToAlbum(with id: String) {
        let viewModel = AlbumViewModel(album: id)
        let viewController = AlbumView(viewModel: viewModel)
        navigation?.pushViewController(viewController, animated: true)
    }
}
