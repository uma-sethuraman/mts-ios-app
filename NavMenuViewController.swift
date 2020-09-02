//
//  NavMenuViewController.swift
//  HoustonMTSApp
//
//  Created by Uma Sethuraman.
//  Copyright © 2019-2020 Houston Meenakshi Temple. All rights reserved.
//

import UIKit

/* The different options in the app sidebar menu */
enum MenuType: Int {
    case home
    case pooja
    case vhs
    case volunteer
    case rentals
    case fb
}

class NavMenuViewController: UITableViewController {

    var clickedMenuType: ((MenuType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /* Display menu options in a tableView format */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true){ [weak self] in
            self?.clickedMenuType?(menuType)
        }
    }

}
