//
//  ParseModels.swift
//  AppAnimal
//
//  Created by renanjunior on 13/08/15.
//  Copyright (c) 2015 renanjunior. All rights reserved.
//

import Foundation

import SwiftyJSON


class ParseModels{
    
    
    // Parse de um objeto JSON para o objet Pet
    func parsePet(json:JSON)->Pet{
     
        let desc:String =  json["pet_descricao"].stringValue
        
        let pet:Pet = Pet(descricao: desc)

        
        
        pet.cuidador = json["cuidador"].stringValue
        pet.email = json["email"].stringValue
        pet.imagem = json["imagem"].stringValue
        
        
        return pet
        
    }
    
    
    
}
