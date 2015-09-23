//
//  Video.swift
//  AppAnimal
//
//  Created by Renan Junior on 22/09/15.
//  Copyright © 2015 renanjunior. All rights reserved.
//

import Foundation


class Video{
    
    
    var titulo:String!
    var urlVideo:String!
    var urlImage:String!
    
    
    func getString()->Dictionary<String,String>{
        
        
        let parameters:Dictionary<String,String> = [
            "titulo": titulo,
            "urlVideo": urlVideo,
            "urlImage": urlImage
        ]
        
        return parameters
    }

    
    
}