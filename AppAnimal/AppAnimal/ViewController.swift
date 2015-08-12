//
//  ViewController.swift
//  AppAnimal
//
//  Created by renanjunior on 04/08/15.
//  Copyright (c) 2015 renanjunior. All rights reserved.
//

import UIKit


import SwiftyJSON

import Alamofire


class ViewController: UIViewController {

    let ws:ClientWS = ClientWS()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pegaListaPets()
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
   
    func pegaDados2(){
        
        let retorno2 = ws.GetPets2()
        
        debugPrint(retorno2)
       
        
    }
    
    func pegaListaPets(){
        
        ws.getPets({retorno, erro in
        
            println("Retorno \(retorno); erro = \(erro)")
            return
        })
        
    }
    


}

