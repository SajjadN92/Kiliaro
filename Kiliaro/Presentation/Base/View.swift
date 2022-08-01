//
//  View.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 7/14/22.
//

import UIKit

protocol View {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
    
    init(viewModel: ViewModelType)
}

extension View where Self: UIViewController {
    init(viewModel: ViewModelType) {
        self.init()
        self.viewModel = viewModel
    }
}
