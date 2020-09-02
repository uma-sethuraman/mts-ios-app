//
//  volunteerViewController.swift
//  HoustonMTSApp
//
//  Created by Uma Sethuraman.
//  Copyright © 2019-2020 Houston Meenakshi Temple. All rights reserved.
//

import Foundation
import UIKit

class volunteerViewController: UIViewController {
    
    /* Slide menu onto screen */
    let transition = SliderMenuTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Set background gradient */
        let backgroundImg = UIImageView(frame: UIScreen.main.bounds)
        backgroundImg.image = UIImage(named: "homepgback.png")
        backgroundImg.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImg, at: 0)
    }
    
    /* When Registration Form button is clicked */
    @IBAction func registrationButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string:"https://docs.google.com/forms/d/1J1RIoSJgQXIKAxc_kqcml8g1xp4UqBN3ZbnoUnu4KdY/edit?usp=sharing")! as URL, options: [:], completionHandler: nil)
    }
    
    /* When WhatsApp button is clicked */
    @IBAction func whatsAppButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string:"https://chat.whatsapp.com/FlLRimd4NwQE50QHRMmpcI")! as URL, options: [:], completionHandler: nil)
    }
    
    /* When menu button is pressed, display menu */
    @IBAction func volunteerMenuButton(_ sender: UIBarButtonItem) {
            guard let navMenuViewController = storyboard?.instantiateViewController(withIdentifier: "NavMenuViewController") as? NavMenuViewController else { return }
                navMenuViewController.clickedMenuType = { menuType in
                    self.changePage(menuType)
                }
                navMenuViewController.modalPresentationStyle = .overCurrentContext
                navMenuViewController.transitioningDelegate = self
                present(navMenuViewController, animated: true)
    }
    
    /* Change page based on which menu item is clicked */
    func changePage(_ menuType: MenuType) {
        switch menuType {
        case .rentals:
            UIApplication.shared.open(URL(string:"https://facility.emeenakshi.org/swesti/home/index.jsp")! as URL, options: [:], completionHandler: nil)
        case .home:
            self.performSegue(withIdentifier: "volunteerToHomeSegue", sender: self)
        case .pooja:
            self.performSegue(withIdentifier: "volunteerToPoojaSegue", sender: self)
        case .vhs:
            self.performSegue(withIdentifier: "volunteerToVhsSegue", sender: self)
        case .fb:
            UIApplication.shared.open(URL(string:"https://www.facebook.com/SriMeenakshiTemple.Pearland")! as URL, options: [:], completionHandler: nil)
        default:
            break
        }
    }
}

/* Allow menu to slide in and slide out onto screen */
extension volunteerViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
