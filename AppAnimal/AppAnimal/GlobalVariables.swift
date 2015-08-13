//
//  GlobalVariables.swift
//  AppAnimal
//
//  Created by renanjunior on 11/08/15.
//  Copyright (c) 2015 renanjunior. All rights reserved.
//

import Foundation


class GlobalVariables {
    
    // These are the properties you can store in your singleton
    private var myName: String = "bob"
    
    // Url base para api rest
    
    //let URL_BASSE = NSURL(string:"https://itunes.apple.com/search?term=angry&country=br&entity=software&lang=pt_br")
     let URL_BASSE : String = "http://pet.brittus.com/"
    
    
    
    
    // Here is how you would get to it without there being a global collision of variables.
    // , or in other words, it is a globally accessable parameter that is specific to the
    // class.
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
}