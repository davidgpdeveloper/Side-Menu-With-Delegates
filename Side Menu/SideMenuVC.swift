//
//  SideMenuVC.swift
//  Side Menu
//
//  Created by Kyle Lee on 8/6/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import UIKit

// Protocol for the controller that needs the action of select options of the SideMenu
protocol SideMenuDelegate {
    func makeSegue(_ option: Int) // Function for the delegate of SideMenu
}

class SideMenuVC: UITableViewController {
    var delegate: SideMenuDelegate! = nil // Delegate for call the methods of the protocol

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        // When select one option of the tableView of SideMenu, send the row number to act.
        delegate.makeSegue(indexPath.row)
    }
}
