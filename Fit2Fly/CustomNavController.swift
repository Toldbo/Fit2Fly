//
//  CustomNavController.swift
//  Fit2Fly
//
//  Created by Christina Toldbo on 11/08/2018.
//  Copyright © 2018 Christina Toldbo. All rights reserved.
//

import UIKit

// creation of custom Navbar to make the navbar transparent https://www.youtube.com/watch?v=Pjz_KU89FSY 
class CustomNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default) //makes the background transparent
        self.navigationBar.shadowImage = UIImage() //makes the little line under the navbar disappear
        

        // Do any additional setup after loading the view.
    }

}
