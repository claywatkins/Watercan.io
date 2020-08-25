//
//  PlantTableViewHelper.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/24/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit

extension PlantTableViewController {
    // MARK: - Helper Methods
    
    func createTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupTableViewCell() {
        tableView.register(PlantTableViewCell.self, forCellReuseIdentifier: "PlantCell")
        tableView.rowHeight = 100
    }
    
    func setupViewAsthetics() {
        overrideUserInterfaceStyle = .dark
        tableView.backgroundColor = .systemGreen
        navigationItem.title = "Plants"
    }
    
    func setUpNavBar() {
        navigationController?.navigationBar.barTintColor = .systemGray6
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        let barButtonAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlantPopup))
        navigationItem.setRightBarButton(barButtonAdd, animated: true)
    }
    
    @objc private func addPlantPopup(){
        animateScaleIn(desiredView: blurView)
        animateScaleInPopUpView()
    }
    
    func createBlurView() {
        blurView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
    func setUpPopUpView() {
        blurView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        popUpView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.7)
        popUpView.backgroundColor = .white
        popUpView.layer.cornerRadius = 20
        popUpView.addComponentsToPopupView()
        popUpView.constrainComponentsToPopupView()
    }
    
    /// Animates a view to scale in and display
    func animateScaleIn(desiredView: UIView) {
        let backgroundView = self.view!
        backgroundView.addSubview(desiredView)
        desiredView.center = backgroundView.center
        desiredView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        desiredView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
            //            desiredView.transform = CGAffineTransform.identity
        }
    }
    
    func animateScaleInPopUpView() {
        blurView.contentView.addSubview(popUpView)
        popUpView.center = blurView.center
        popUpView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        popUpView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            self.popUpView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.popUpView.alpha = 1
            //            desiredView.transform = CGAffineTransform.identity
        }
    }
    
    
    func animateScaleOut(desiredView: UIView) {
        UIView.animate(withDuration: 0.2, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            desiredView.alpha = 0
        }, completion: { (success: Bool) in
            desiredView.removeFromSuperview()
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            
        }, completion: { _ in
            
        })
    }
}
