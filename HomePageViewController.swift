//
//  HomePageViewController.swift
//  HoustonMTSApp
//
//  Created by Uma Sethuraman.
//  Copyright © 2019-2020 Houston Meenakshi Temple. All rights reserved.
//

import UIKit
import MapKit

class HomePageViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    /* For image view on home page */
    @IBOutlet weak var homePageCollectionView: UICollectionView!
    @IBOutlet weak var timingsButtonOutlet: UIButton!
    var imageArray:[String] = ["1.jpg", "6.jpg", "2.jpg", "3.jpg"]
    var count = 0
    var slideshowTimer = Timer()
    
    /* For menu to slide out onto screen */
    let transition = SliderMenuTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Set background gradient */
        let backgroundImg = UIImageView(frame: UIScreen.main.bounds)
        backgroundImg.image = UIImage(named: "homepgback.png")
        backgroundImg.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImg, at: 0)
        
        /* Set up slideshow of images on home page */
        slideshowTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }

    /* Shows menu when menu button is clicked */
    @IBAction func MenuButton(_ sender: UIBarButtonItem) {
        guard let navMenuViewController = storyboard?.instantiateViewController(withIdentifier: "NavMenuViewController") as? NavMenuViewController else { return }
        navMenuViewController.clickedMenuType = { menuType in
            self.changePage(menuType)
        }
        navMenuViewController.modalPresentationStyle = .overCurrentContext
        navMenuViewController.transitioningDelegate = self
        present(navMenuViewController, animated: true)
    }
    
    /* Changes page based on which menu item is clicked */
    /* Either opens a certain form or goes to the page requested
       based on which option is clicked */
    func changePage(_ menuType: MenuType) {
        switch menuType {
        case .rentals:
       UIApplication.shared.open(URL(string:"https://facility.emeenakshi.org/swesti/home/index.jsp")! as URL, options: [:], completionHandler: nil)
        case .pooja:
            self.performSegue(withIdentifier: "PoojaSegue", sender: self)
        case .vhs:
            self.performSegue(withIdentifier: "HomeToVHSSegue", sender: self)
        case .volunteer:
            self.performSegue(withIdentifier: "homeToVolunteerSegue", sender: self)
        case .fb:
        UIApplication.shared.open(URL(string:"https://www.facebook.com/SriMeenakshiTemple.Pearland")! as URL, options: [:], completionHandler: nil)
        default:
            break
        }
    }
    
    /* Change slideshow image every 3 seconds */
    @objc func changeImage() {
        if count < imageArray.count {
            let index = IndexPath.init(item: count, section: 0)
            self.homePageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            count += 1
        }
        else {
            count = 0
            let index = IndexPath.init(item: count, section: 0)
            self.homePageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
        }
    }
    
    /* Sets up collection view for image slideshow */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    /* Sets up collection view for image slideshow */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = homePageCollectionView.dequeueReusableCell(withReuseIdentifier: "imageScrollerID", for: indexPath) as! MyCollectionViewCell
        
        imageCell.homePageImage.contentMode = .scaleAspectFill;
        imageCell.homePageImage.clipsToBounds = true;
        if (count == imageArray.count){
            count = 0
        }
        imageCell.homePageImage.image = UIImage(named: imageArray[count])
        
        return imageCell
    }
    
    /* When Calendar button is clicked */
    @IBAction func CalendarButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string:"https://drive.google.com/file/d/1lwJeaCvc10q2Q2FyhZA-Ad0zG2sI624S/view?usp=sharing")! as URL, options: [:], completionHandler: nil)
    }
    
    /* When Directions button is clicked */
    @IBAction func TempleDirectionsButton(_ sender: UIButton) {
        
        /* Meenakshi Temple Latitude and Longitude */
        let latitude:CLLocationDegrees = 29.523059
        let longitude:CLLocationDegrees = -95.297626
        
        let distance:CLLocationDistance = 1000;
        let destCoordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateRegion(center: destCoordinates, latitudinalMeters: distance, longitudinalMeters: distance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: span.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: span.span)]
        
        let placemark = MKPlacemark(coordinate: destCoordinates)
        let myMapItem = MKMapItem(placemark: placemark)
        myMapItem.name = "Sri Meenakshi Devasthanam"
        myMapItem.openInMaps(launchOptions: options)
    }
    
    /* When Subscribe button is clicked */
    @IBAction func EmailSubscribeButton(_ sender: UIButton)
    {
        UIApplication.shared.open(URL(string:"https://visitor.r20.constantcontact.com/manage/optin?v=001HTk7N6nZumLUO68TJZop-2uyIpg_ZalrSLfSdmbM7JhcJ6FDcCjvzpLsTQJJ6LT1TALA0XgVOXnxWCLaDFj7TOHQqWGyG54oUHaFtal10D0%3D")! as URL, options: [:], completionHandler: nil)
    }
    
    /* When Website button is clicked */
    @IBAction func MTSWebsiteButton(_ sender: UIButton) {
    UIApplication.shared.open(URL(string:"https://www.emeenakshi.org")! as URL, options: [:], completionHandler: nil)
    }
    
    /* When Dress Code button is clicked */
    @IBAction func dressCodeButton(_ sender: Any) {
        self.performSegue(withIdentifier: "DressCodeSegue", sender: self)
    }
    
    /* When Timings button is clicked */
    @IBAction func templeTimingsButtonAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeToTimingsSegue", sender: self)
    }
}

/* Linked with menu animation when menu button is pressed */
extension HomePageViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
