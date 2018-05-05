//
//  MainVC.swift
//  Side Menu
//
//

import UIKit

class MainVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftItemsSupplementBackButton = false
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.5607843137, blue: 0, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        self.navigationItem.setLeftBarButtonItems([generateMenuBarButtonItem()], animated: true)
        self.navigationItem.titleView = generateCentralButton()
    }
}
