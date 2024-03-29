//
//  Alerta.swift
//  Carros
//
//  Created by Bruno Brito on 15/08/15.
//  Copyright (c) 2015 Bruno Brito. All rights reserved.
//

import UIKit

class Alerta {
    
    class func alerta(msg:String, viewController:UIViewController) {
        
        let alert = UIAlertController(title: "Alerta", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        viewController.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
}
