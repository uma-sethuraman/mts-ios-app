//
//  vhsViewController.swift
//  HoustonMTSApp
//
//  Created by Uma Sethuraman.
//  Copyright © 2019-2020 Houston Meenakshi Temple. All rights reserved.
//

import Foundation
import UIKit

class vhsViewController: UIViewController {
    
    /* For menu to slide out onto screen */
    let transition = SliderMenuTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Set background gradient */
        let backgroundImg = UIImageView(frame: UIScreen.main.bounds)
        backgroundImg.image = UIImage(named: "homepgback.png")
        backgroundImg.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImg, at: 0)
    }
    
    /* When menu button is pressed, display menu */
    @IBAction func vhsMenuButton(_ sender: UIBarButtonItem) {
        guard let navMenuViewController = storyboard?.instantiateViewController(withIdentifier: "NavMenuViewController") as? NavMenuViewController else { return }
        navMenuViewController.clickedMenuType = { menuType in
            self.changePage(menuType)
        }
        navMenuViewController.modalPresentationStyle = .overCurrentContext
        navMenuViewController.transitioningDelegate = self
        present(navMenuViewController, animated: true)
    }
    
    /* Change page based on which menu item is pressed */
    func changePage(_ menuType: MenuType) {
        switch menuType {
        case .rentals:
            UIApplication.shared.open(URL(string:"https://facility.emeenakshi.org/swesti/home/index.jsp")! as URL, options: [:], completionHandler: nil)
        case .home:
            self.performSegue(withIdentifier: "VHSToHomeSegue", sender: self)
        case .pooja:
            self.performSegue(withIdentifier: "VHSToPoojaSegue", sender: self)
        case .volunteer:
            self.performSegue(withIdentifier: "vhsToVolunteerSegue", sender: self)
        case .fb:
            UIApplication.shared.open(URL(string:"https://www.facebook.com/SriMeenakshiTemple.Pearland")! as URL, options: [:], completionHandler: nil)
        default:
            break
        }
    }
    
    /* When VHS website button is clicked */
    @IBAction func vhsWebsiteButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string:"https://mtsvhs.blogspot.com/")! as URL, options: [:], completionHandler: nil)
    }
}

/* To allow menu to slide in and slide out onto screen */
extension vhsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}

