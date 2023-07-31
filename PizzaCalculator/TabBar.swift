//
//  TabBar.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 16.07.23.
//

import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
           UITabBar.appearance().barTintColor = .systemBackground
           tabBar.tintColor = .label
           setupVCs()
    }

    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
    
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
        
      }
    
    func setupVCs() {
        
          viewControllers = [
            createNavController(for: PizzaCalculatorViewController(), title: "Pizza Picker", image: UIImage(systemName: "plus.circle")!),
              createNavController(for: StartMenuViewController(), title: "Home", image: UIImage(systemName: "house")!),
              createNavController(for: ProfileViewController(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person")!)
          ]
      }

}
