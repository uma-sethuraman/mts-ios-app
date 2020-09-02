//
//  DressCodeViewController.swift
//  HoustonMTSApp
//
//  Created by Uma Sethuraman.
//  Copyright © 2019-2020 Houston Meenakshi Temple. All rights reserved.
//

import Foundation
import UIKit

class DressCodeViewController: UIViewController {
    
    /* For menu to slide out when menu button is pressed */
    let transition = SliderMenuTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Set background gradient */
        let backgroundImg = UIImageView(frame: UIScreen.main.bounds)
        backgroundImg.image = UIImage(named: "homepgback.png")
        backgroundImg.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImg, at: 0)
        
    }
    
    /* Show menu when menu button is pressed */
    @IBAction func dressCodeMenuButton(_ sender: UIBarButtonItem) {
        guard let navMenuViewController = storyboard?.instantiateViewController(withIdentifier: "NavMenuViewController") as? NavMenuViewController else { return }
        navMenuViewController.clickedMenuType = { menuType in
            self.changePage(menuType)
        }
        navMenuViewController.modalPresentationStyle = .overCurrentContext
        navMenuViewController.transitioningDelegate = self
        present(navMenuViewController, animated: true)
    }
    
    /* Change page to the menu item that was clicked */
    func changePage(_ menuType: MenuType) {
        switch menuType {
        case .home:
            self.performSegue(withIdentifier: "DressCodeToHomeSegue", sender: self)
        case .pooja:
            self.performSegue(withIdentifier: "DressCodeToPoojaSegue", sender: self)
        case .vhs:
            self.performSegue(withIdentifier: "DressCodeToVHSSegue", sender: self)
        case .volunteer:
            self.performSegue(withIdentifier: "DressCodeToVolunteerSegue", sender: self)
        case .rentals:
            UIApplication.shared.open(URL(string:"https://facility.emeenakshi.org/swesti/home/index.jsp")! as URL, options: [:], completionHandler: nil)
        case .fb:
            UIApplication.shared.open(URL(string:"https://www.facebook.com/SriMeenakshiTemple.Pearland")! as URL, options: [:], completionHandler: nil)
        }
    }
}

/* Linked to menu button */
/* Allows menu to transition on and off the screen */
extension DressCodeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
