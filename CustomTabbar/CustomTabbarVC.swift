//
//  CustomTabbarVC.swift
//  CustomTabbar
//
//  Created by AKANKSHA GARG on 26/12/17.
//  Copyright © 2017 Akanksha. All rights reserved.
//

import UIKit

enum ChildController: Int {
    
    case Favorites = 0
    case Home
    case Bookmarks
}

class CustomTabbarVC: UITabBarController {
    
    var homeButton: UIButton!
    
    // MARK: - View Lifecycle Methods
    
    override func viewDidLoad() {
        
        // Do any additional setup after loading the view.
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        super.viewDidLoad()
        setupHomeButton()
        //Pass the index of center item
        selectedIndex = ChildController.Home.rawValue
        self.tabBarButtonZoomedIn()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom Methods
    
    func setupHomeButton() {
        //Custom Button
        homeButton = UIButton(frame: CGRect(x: 10, y: 0, width: 45, height: 45))
        var homeButtonFrame = homeButton.frame
        homeButtonFrame.origin.x = view.bounds.width/2 - homeButtonFrame.size.width/2
        homeButton.frame = homeButtonFrame
        homeButton.layer.cornerRadius = homeButtonFrame.height/2
        homeButton.setImage(#imageLiteral(resourceName: "UnSelected"), for: .normal)
        homeButton.addTarget(self, action: #selector(CustomTabbarVC.homeButtonClicked(_:)), for: .touchUpInside)
        self.tabBar.addSubview(homeButton)
        self.tabBar.bringSubview(toFront: homeButton)
        view.layoutIfNeeded()
    }
    
    @objc func homeButtonClicked(_ sender: UIButton) {
        self.selectItemWithIndex(value: ChildController.Home.rawValue)
    }
    
    // To zoom out Center custom Button with SPRING animation effect.
    private func tabBarButtonZoomedOut() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.homeButton.setImage(#imageLiteral(resourceName: "UnSelected"), for: .normal)
            self.homeButton.transform = .identity
            self.homeButton.frame.origin.y =  2
        }, completion: nil)
    }
    
    // To zoom in Center custom Button with SPRING animation effect.
    private func tabBarButtonZoomedIn() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.homeButton.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
            self.homeButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.homeButton.frame.origin.y =  -(self.homeButton.frame.height/2.5)
        }, completion: nil)
    }
    
    //Call this method from any child controller to change the selected index
    func selectItemWithIndex(value: Int) {
        
        self.selectedIndex = value
        if let item = tabBar.items?[value] {
            self.tabBar(self.tabBar, didSelect: item)
        }
    }
}

extension CustomTabbarVC {
    // MARK: - Tabbar Delegate
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item == tabBar.items?[ChildController.Home.rawValue] {
            self.tabBarButtonZoomedIn()
        } else {
            self.tabBarButtonZoomedOut()
        }
    }
}
