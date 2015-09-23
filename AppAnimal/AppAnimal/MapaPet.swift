//
//  MapaPet.swift
//  AppAnimal
//
//  Created by Renan Junior on 22/09/15.
//  Copyright © 2015 renanjunior. All rights reserved.
//

import UIKit




class MapaPet : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = self.title
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(30.0)
        self.navigationItem.titleView = label

        
        
    }
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    

    
}