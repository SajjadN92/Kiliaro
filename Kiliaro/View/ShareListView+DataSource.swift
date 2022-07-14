//
//  ShareListView+DataSource.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 7/14/22.
//

import UIKit

extension ShareListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reuse(UITableViewCell.self, indexPath)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = viewModel.getConfiguration(for: cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTableRows()
    }
    
}
