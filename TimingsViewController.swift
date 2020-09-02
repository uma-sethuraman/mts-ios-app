//
//  TimingsViewController.swift
//  HoustonMTSApp
//
//  Created by Uma Sethuraman.
//  Copyright © 2019-2020 Houston Meenakshi Temple. All rights reserved.
//

import Foundation
import UIKit

class TimingsViewController: UIViewController {

    /* For menu to slide out when menu button is pressed */
    let transition = SliderMenuTransition()
    
    @IBOutlet weak var timingsInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Set background gradient */
        let backgroundImg = UIImageView(frame: UIScreen.main.bounds)
        backgroundImg.image = UIImage(named: "homepgback.png")
        backgroundImg.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImg, at: 0)
    }
    
    /* When menu button is pressed in navigation bar */
    @IBAction func timingsMenuButton(_ sender: UIBarButtonItem) {
        guard let navMenuViewController = storyboard?.instantiateViewController(withIdentifier: "NavMenuViewController") as? NavMenuViewController else { return }
        navMenuViewController.clickedMenuType = { menuType in
            self.changePage(menuType)
        }
        navMenuViewController.modalPresentationStyle = .overCurrentContext
        navMenuViewController.transitioningDelegate = self
        present(navMenuViewController, animated: true)
    }
    
    /* Change page based on which menu item was clicked */
    func changePage(_ menuType: MenuType) {
        switch menuType {
        case .rentals:
            UIApplication.shared.open(URL(string:"https://facility.emeenakshi.org/swesti/home/index.jsp")! as URL, options: [:], completionHandler: nil)
        case .home:
            self.performSegue(withIdentifier: "TimingsToHomeSegue", sender: self)
        case .pooja:
            self.performSegue(withIdentifier: "TimingsToPoojaSegue", sender: self)
        case .vhs:
            self.performSegue(withIdentifier: "TimingsToVHSSegue", sender: self)
        case .volunteer:
            self.performSegue(withIdentifier: "TimingsToVolunteerSegue", sender: self)
        case .fb:
            UIApplication.shared.open(URL(string:"https://www.facebook.com/SriMeenakshiTemple.Pearland")! as URL, options: [:], completionHandler: nil)
        }
    }
    
}

/* Linked to menu transition */
/* Allows menu to transition on and off the screen */
extension TimingsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
