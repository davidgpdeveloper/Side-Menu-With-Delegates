//
//  BaseViewController.swift
//  Side Menu
//
//  Created by Victor Developer on 7/11/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import UIKit

// Because when we go from one BAseViewController to another,
// the delegate resets, we need one property where make a backaup of the delegate
var delegateTmp: BaseViewControllerDelegate! = nil

protocol BaseViewControllerDelegate {
    // Function that the delegate of BaseViewController must implement for open the sideMenu.
    func openMenu()
    var isMenuOpen: Bool { get }
}

class BaseViewController: UIViewController {
    // Delegate object for call the functions of the delegate
    var delegate: BaseViewControllerDelegate?
    // SideMenudelegate to use the Delegate functions of open other viewcontrollers from SideMenu
    var sideMenuDelegate: SideMenuDelegate?
    // Gesture to set the the view or remove from view
    var swipeRight: UISwipeGestureRecognizer! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Did Load Base VC")

        // Backup or assign Delegate of BaseViewController
        // If The backup is empty but the delegate is not empty, asign delegate to the backup
        if delegateTmp == nil && delegate != nil {
            delegateTmp = delegate
        } else {
            delegate = delegateTmp // If backup is not empty, set the backup to the delegate
        }

        sideMenuDelegate = self // Define self like Delegate of SideMenu to take the call of select items from SideMenu

        //Set navigation item color and buttons
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftItemsSupplementBackButton = false
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.5607843137, blue: 0, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationItem.setLeftBarButtonItems([generateBackBarButtonItem(),
                                                   generateMenuBarButtonItem()],
                                                  animated: true)
        self.navigationItem.titleView = generateCentralButton()

        // Initialize swipe gesture
        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(closeSideMenu(sender:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.left

    }

    // Function to construct the back button for the NavigationItem
    func generateBackBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(image: #imageLiteral(resourceName: "left_arrow_white"), style: .plain, target: self, action: #selector(backTapped(sender:)))
    }

    // Function to construct the menu button for the NavigationItem
    func generateMenuBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu"), style: .plain, target: self, action: #selector(openMenu(sender:)))
    }

    // Function to construct the central button to go to the mail view
    func generateCentralButton() -> UIButton {
        let button =  UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.setTitle("Hola", for: .normal)
        button.addTarget(self, action: #selector(backTapped(sender:)), for: .touchUpInside)
        return button
    }

    // Function that is called when push the hamburguer button
    @objc func openMenu(sender: UIButton) {
        delegate?.openMenu()
        view.addGestureRecognizer(swipeRight)
    }

    // Function that is called when swipe from right to left
    @objc func closeSideMenu(sender: Any) {
        delegate?.openMenu()
        view.removeGestureRecognizer(swipeRight)
    }

    // Function that is called when push the back arrow
    @objc func backTapped(sender: UIButton) {
        if let isOpen = delegate?.isMenuOpen, isOpen == true {
            delegate?.openMenu()
        }
        self.navigationController?.popToRootViewController(animated: true)
    }

    // Call when one item from the list of the SideMenu is selected
    func showProfile() {
        performSegue(withIdentifier: "ShowProfile", sender: nil)
    }

    func showSettings() {
        performSegue(withIdentifier: "ShowSettings", sender: nil)
    }

    func showSignIn() {
        performSegue(withIdentifier: "ShowSignIn", sender: nil)
    }

}

// Delegate actions to perform segues
extension BaseViewController: SideMenuDelegate {
    func makeSegue(_ option: Int) {
        delegate?.openMenu()
        switch option {
        case 0: showProfile()
        case 1: showSettings()
        case 2: showSignIn()
        default: return
        }
    }
}
