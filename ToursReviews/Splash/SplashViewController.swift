//
//  SplashViewController.swift
//  ToursReviews
//
//  Created by Balu Naik on 7/13/19.
//  Copyright © 2019 Balu Naik. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            self.setUpListScreen()
        }
    }
    
    
    //MARK: Private Method
    
    fileprivate func setUpListScreen() {
        let assesmble = TRListAssembly()
        let navigationController = UINavigationController(rootViewController: assesmble.assemblyModule())
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
}
