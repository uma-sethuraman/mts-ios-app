//
//  PoojaViewController.swift
//  HoustonMTSApp
//
//  Created by Uma Sethuraman.
//  Copyright © 2019-2020 Houston Meenakshi Temple. All rights reserved.
//

import Foundation
import UIKit

class PoojaViewController: UIViewController {
    
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
    
    /* When menu button is clicked, display menu */
    @IBAction func PoojaMenuButton(_ sender: UIBarButtonItem) {
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
            self.performSegue(withIdentifier: "PoojaToHomeSegue", sender: self)
        case .vhs:
            self.performSegue(withIdentifier: "PoojaToVHSSegue", sender: self)
        case .volunteer:
            self.performSegue(withIdentifier: "poojaToVolunteerSegue", sender: self)
        case .fb:
            UIApplication.shared.open(URL(string:"https://www.facebook.com/SriMeenakshiTemple.Pearland")! as URL, options: [:], completionHandler: nil)
        default:
            break
        }
    }
    
    /* When Pooja Events/Info button is clicked */
    @IBAction func poojaEventsButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string:"https://www.emeenakshi.org/")! as URL, options: [:], completionHandler: nil)
    }
    
    /* When Pooja Bookings button is clicked */
    @IBAction func poojaBookingsButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string:"https://docs.google.com/forms/d/e/1FAIpQLScUfOkihxK0VoLzu6DaOlk_GZZo7vCKYXcbyiwoRqsqooV5og/viewform")! as URL, options: [:], completionHandler: nil)
    }
    
    /* When Pooja Items button is clicked */
    @IBAction func poojaItemsButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string:"https://www.emeenakshi.org/Database/Forms/Pooja%20Items%20v2.pdf")! as URL, options: [:], completionHandler: nil)
    }
}

/* In order for menu to slide out when needed */
extension PoojaViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
