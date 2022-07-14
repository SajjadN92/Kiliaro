//
//  ShareListView.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 7/14/22.
//

import UIKit

class ShareListView: BaseViewController, View {
    var viewModel: ShareListViewModel!
    
    lazy var shareTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func addSubviews() {
        
    }
    
    override func setupConstraints() {
        
    }
    
}
