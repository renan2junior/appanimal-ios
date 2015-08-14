//
//  ClientSW.swift
//  AppAnimal
//
//  Created by renanjunior on 11/08/15.
//  Copyright (c) 2015 renanjunior. All rights reserved.
//

import Foundation

import SwiftyJSON

import Alamofire

//import ParseModels



/*

Segue instruções para uso dos serviços:

Obs: Desconsiderar o campo _id, trata-se do id do mongo.

Listar Pets

http://pet.brittus.com/pets/
Metodo GET

Buscar por id

http://pet.brittus.com/pets/1
Metodo GET

Listar Pet por tipo

http://pet.brittus.com/pets/tipo/cachorro
Metodo GET

Salvar Pet (Gravar e Atualizar)

http://pet.brittus.com/pets/
Metodo POST

Se passar no body sem idpet ele grava um novo, exemplo:
{
"pet_nome" : "Toto",
"pet_sexo" : "macho",
"pet_idade" : "2",
"pet_descricao" : "Toto",
"pet_tipo_dade" : ".",
"pet_porte" : "grande",
"pet_raca" : "vira-lata",
"pet_tipo" : "cachorro",
"pet_status" : "aprovado"
}

Se passar no body com idpet ele atualiza existente, exemplo:
{
"idpet" : "2",
"pet_descricao" : "Toto maneiro"
}

Apagar Pet

http://pet.brittus.com/pets/1
Metodo DELETE


*/



class ClientWS{
    
    
    var retorno:JSON = JSON.nullJSON
    
    let parse:ParseModels = ParseModels()

   
    // Retornar lista de Pets
    // Retorno JSON
    func GetPets2()->JSON{
        
        Alamofire.request(.GET, GlobalVariables.sharedManager.URL_BASSE+"pets", parameters: nil)
            .responseJSON{(req, res, json, error) in
         
                if(error != nil){
                    println("ERRO")
                }else{
                    println("SUCESSO")
                    
                    println(JSON(json!))
                    
                    self.retorno = JSON(json!)
                    
                }
                
        }
        
        return self.retorno
    }
    
    
    
    // Retornar lista de Pets
    // Retorno Array
    func getPets(completionHandler: (responseObject: NSArray?, error: NSError?) -> ()) {
        makeCall(completionHandler)
    }
    
    func makeCall(completionHandler: (responseObject: NSArray?, error: NSError?) -> ()) {
        
        debugPrint(GlobalVariables.sharedManager.URL_BASSE+"pets")
        
        Alamofire.request(.GET, GlobalVariables.sharedManager.URL_BASSE+"pets", parameters: nil)
            .responseJSON { request, response, responseObject, error in
                completionHandler(responseObject: responseObject as? NSArray, error: error)
        }
    }
    
    
    
    // Retornar um Pet
    // Retorno JSON
    func getPet(idpet:String,  completionHandler: (responseObject: Pet, error: NSError?) -> ()) {
        makeCall(idpet, completionHandler: completionHandler)
    }
    
    func makeCall(idpet:String, completionHandler: (responseObject: Pet, error: NSError?) -> ()) {
        
        debugPrint(GlobalVariables.sharedManager.URL_BASSE+"pets/\(idpet)")
        
        Alamofire.request(.GET, GlobalVariables.sharedManager.URL_BASSE+"pets/\(idpet)", parameters: nil)
            .responseJSON { (request, response, responseObject, error) in
                if(error != nil){
                    debugPrint(" o Erro foi \(error)")
                }else{
                    var json:JSON = JSON(responseObject!)
                    
                    // Chamando metodo para parsear o retorno
                    let pet:Pet = self.parse.parsePet(json)
                    
                    
                    completionHandler(responseObject: pet, error: error)
                }
        }
    }

    
    

}