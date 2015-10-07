//
//  Pet.swift
//  AppAnimal
//
//  Created by renanjunior on 13/08/15.
//  Copyright (c) 2015 renanjunior. All rights reserved.
//

import Foundation



class Pet {

    
    var cuidador:String!
    var email:String!
    var telefone:String!
    var imagem:String!
    var descricao:String!
    var pet_nome:String!
    var pet_descricao:String!
    var pet_tipo:String!
    var pet_raca:String!
    var pet_tipo_idade:String!
    var pet_idade:String!
    var pet_porte:String!
    var pet_genero:String!
    
    
    func getString()->Dictionary<String,String>{
        
        
        let parameters:Dictionary<String,String> = [
            "pet_nome": pet_nome,
            "pet_descricao": pet_descricao,
            "pet_tipo":pet_tipo,
            "pet_tipo_idade":pet_tipo_idade,
            "pet_raca":pet_raca,
            "pet_idade":pet_idade,
            "pet_porte":pet_porte,
            "pet_genero":pet_genero,
            "imagem":imagem,
            "cuidador":cuidador,
            "email":email,
            "telefone":telefone,
            "descricao":descricao
        ]

        return parameters
    }
    
}
