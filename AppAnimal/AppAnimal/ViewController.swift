//
//  ViewController.swift
//  AppAnimal
//
//  Created by renanjunior on 04/08/15.
//  Copyright (c) 2015 renanjunior. All rights reserved.
//

import UIKit

import Alamofire




class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        pegaDados();
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func pegaDados(){
        
        Alamofire.request(.GET, "https://itunes.apple.com/search?term=angry&country=br&entity=software&lang=pt_br", parameters: ["kind": "software"])
            .response { request, response, data, error in
                println(request)
                println(response)
                println(error)
        }
        
        
        
    }


}

