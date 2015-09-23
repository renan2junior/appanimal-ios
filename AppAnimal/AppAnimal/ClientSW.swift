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
    
    
    var retorno:JSON = JSON.null
    
    let parse:ParseModels = ParseModels()

   
    
    
    // Retornar lista de Pets
    // Retorno Array
    func getPets(completionHandler: (responseObject: JSON?) -> ()) {
        makeCall(completionHandler)
    }
    
    func makeCall(completionHandler: (responseObject: JSON?) -> ()) {
        
        debugPrint(GlobalVariables.sharedManager.URL_BASSE+"pets", terminator: "")
        
        let headers = ["Authorization":"Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==","Content-Type":"application/x-www-form-urlencoded"]
        
        Alamofire.request(.GET, GlobalVariables.sharedManager.URL_BASSE+"pets", headers:headers)
            .responseJSON { _,  _, response in
                
                let json:JSON = JSON(response.value!)
                
                completionHandler(responseObject: json)
        }
    }
    
    // Retornar lista de Pets filtrado por tipo
    // Retorno Array
    func getPetsByTipo(completionHandler: (responseObject: JSON?) -> (), tipo:String) {
        makeCallTipo(completionHandler, tipo: tipo)
    }
    
    func makeCallTipo(completionHandler: (responseObject: JSON?) -> (), tipo:String) {
        
        debugPrint(GlobalVariables.sharedManager.URL_BASSE+"pets/tipo/\(tipo)", terminator: "")
        
        let headers = ["Authorization":"Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==","Content-Type":"application/x-www-form-urlencoded"]
        
        Alamofire.request(.GET, GlobalVariables.sharedManager.URL_BASSE+"pets/tipo/\(tipo)", headers:headers)
            .responseJSON { _,  _, response in
                
                let json:JSON = JSON(response.value!)
                
                completionHandler(responseObject: json)
        }
    }

    
    // Retornar um Pet
    // Retorno JSON
    func getPet(idpet:String,  completionHandler: (responseObject: Pet) -> ()) {
        makeCall(idpet, completionHandler: completionHandler)
    }
    
    func makeCall(idpet:String, completionHandler: (responseObject: Pet) -> ()) {
        
        debugPrint(GlobalVariables.sharedManager.URL_BASSE+"pets/\(idpet)", terminator: "")
        
        
        
        Alamofire.request(.GET, GlobalVariables.sharedManager.URL_BASSE+"pets/\(idpet)", parameters: nil)
            .responseJSON { (request, response, responseObject) in
                let json:JSON = JSON.null; // = JSON(responseObject!)
                    
                    // Chamando metodo para parsear o retorno
                    let pet:Pet = self.parse.parsePet(json)
                    
                    
                    completionHandler(responseObject: pet)
                
        }
    }
    
    

    // Salvar um Pet
    // Retorna JSON
    
    func postPet(pet:Pet){

        makePostCall(pet)
    }
    
    func makePostCall(pet:Pet){
     
        Alamofire.request(.POST, GlobalVariables.sharedManager.URL_BASSE+"pets", parameters:pet.getString() , encoding: .JSON)
            .responseJSON { (request, response, responseObject) in
         //                          var json:JSON = JSON(responseObject!)
                    
                       }
        
    }
    
    
    // Apagar pet
    
    func deletePet(idPet:Int){

        makeDeleteCall(idPet)
        
    }
    
    func makeDeleteCall(idPet:Int){
        
        debugPrint(" url : \(GlobalVariables.sharedManager.URL_BASSE)pets/\(idPet)", terminator: "")
        
        Alamofire.request(.DELETE, GlobalVariables.sharedManager.URL_BASSE+"pets/\(idPet)") .responseJSON { (request, response, responseObject) in
             //              var json:JSON = JSON(responseObject!)
                
                     }
        
        
        
    }
    
    
    
    
    

}