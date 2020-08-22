//
//  TabBar.swift
//  WaterMyPlantsBW
//
//  Created by Bronson Mullens on 8/20/20.
//  Copyright © 2020 Bronson Mullens. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        setUpTabBar()
    }
    
    func setUpTabBar() {
        let tableVC = createNavController(vc: PlantCollectionTableViewController(),
                            imageName: "house",
                            selectedImageName: "house.fill",
                            title: "Plants")
        
        // For example only - Delete
        let loginVC = createNavController(vc: LoginViewController(),
        imageName: "house",
        selectedImageName: "house.fill",
        title: "Login")
         
          /*let settingsVC = createNavController(vc: SettingsViewController(),
                             imageName: "house",
                             selectedImageName: "house.fill",
                             title: "Settings")*/
        viewControllers = [tableVC, loginVC/* , settingsVC */]
        
        // Appearance of tab bar
        tabBar.barTintColor = .systemGray6
        tabBar.tintColor = .white
    }

}

extension UITabBarController {
    
    func createNavController(vc: UIViewController, imageName: String, selectedImageName: String, title: String) -> UINavigationController {
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        navController.tabBarItem.image = UIImage(systemName: selectedImageName)
        return navController
    }
    
}
