//
//  ShareListViewModel.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 7/14/22.
//

import UIKit

class ShareListViewModel: ViewModel {
    private var shareList = ["djlCbGusTJamg_ca4axEVw"]
    
    func numberOfTableRows() -> Int {
        return shareList.count
    }
    
    func rowHeight() -> CGFloat {
        return 60
    }
    
    func getConfiguration(for cell: UITableViewCell, at indexPath: IndexPath) -> UIListContentConfiguration {
        var config = cell.defaultContentConfiguration()
        config.text = shareList[indexPath.row]
        config.textProperties.color = ThemeManager.currentTheme.textColor
        return config
    }
    
    func getTitle() -> String {
        return "shared_items".localized.uppercased()
    }
    
    func tableRowSelected(at index: Int) {
        
    }
}
