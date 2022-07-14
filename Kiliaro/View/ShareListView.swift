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
        tableView.register(UITableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func configViewController() {
        super.configViewController()
        title = viewModel.getTitle()
    }
    
    override func addSubviews() {
        view.addSubview(shareTable)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            shareTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shareTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shareTable.topAnchor.constraint(equalTo: view.topAnchor),
            shareTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
