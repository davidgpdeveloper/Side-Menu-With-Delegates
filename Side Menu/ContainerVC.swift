//
//  ViewController.swift
//  Side Menu
//
//
/**
 This is the view containers controller, side menu and main view.
 When the app opens, this controller call the 2 segues to show SideMenu and MainView
 For make the toggle of the SideMenu, we use a Constraint.
 **/
import UIKit

class ContainerVC: UIViewController {

    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint! // Constraint to show or hide the side menu
    var sideMenuOpen = false // Bool to indicate if side menu is open or not
    var baseViewController: BaseViewController! = nil // Instance of the MainView
    var sideMenuController: SideMenuVC! = nil //SideMenu instance

    // To manage the open and close sideMenu and the segues to the other ViewController,
    // make self delegate of MainView for the push burguer button to open or close side menu and,
    // make MainViewController delegate of hte sideMenu to controll selection of the items inside the SideMenu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openFirstView" {
            print("openFirstView SEGUE")
            if let navigationController = segue.destination as? UINavigationController {
                if let viewControllerFromNavigationStack =
                    navigationController.viewControllers[0] as? BaseViewController {
                    // Save the first viewController on the naivgationController Stack as
                    // BaseViewController to manage segues inside
                    baseViewController = viewControllerFromNavigationStack
                }
            }
        }

        if segue.identifier == "sideMenuSegue"{
            print("sideMenuSegue SEGUE")
            // Save an instance of sideMenuVC to manage the interaction with TableViewCell
            if let smc = segue.destination as? SideMenuVC {
                sideMenuController = smc
            }
        }
        // Because we don't controll when system run one or other segue,
        // call the delegate asignations in all segues action
        delegates()
    }

    // Make delegate asignations
    func delegates() {
        // In case all viewControllers instance are diferent to nil, asign delegates.
        if baseViewController != nil && sideMenuController != nil {
            baseViewController.delegate =  self
            sideMenuController.delegate = baseViewController
        }
    }

    // Show and hide SideMenu
    func toggleSideMenu() {
        if sideMenuOpen {
            sideMenuOpen = false
            sideMenuConstraint.constant = -240
        } else {
            sideMenuOpen = true
            sideMenuConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
// Extension para poder abrir o cerrar el menu lateral desde el Delegate.
extension ContainerVC: BaseViewControllerDelegate {
    func openMenu() {
        toggleSideMenu()
    }
    
    var isMenuOpen: Bool {
        return sideMenuOpen
    }
}
