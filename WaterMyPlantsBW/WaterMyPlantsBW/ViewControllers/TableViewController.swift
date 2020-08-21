//
//  TableViewController.swift
//  WaterMyPlantsBW
//
//  Created by Bronson Mullens on 8/20/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = .systemGreen
        navigationItem.title = "Plants"
        guard let navController = navigationController else { return }
        navController.navigationBar.prefersLargeTitles = true
        
        // setUpNavBar()
    }
    
}
/*
 // Use this to customize the nav bar. Do it on each VC.
extension UIViewController {
    
    func setUpNavBar() {
        navigationController?.navigationBar.barTintColor = .systemGray6
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
}
*/
