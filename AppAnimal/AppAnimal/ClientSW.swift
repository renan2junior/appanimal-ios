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

class ClientWS{

    var retorno:JSON = JSON.null
    let parse:ParseModels = ParseModels()
    let headers = ["Authorization":"Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==","Content-Type":"application/x-www-form-urlencoded"]

    // Retornar lista de Pets
    // Retorno Array
    func getPets(completionHandler: (responseObject: JSON?) -> ()) {
        makeCall(completionHandler)
    }
    
    func makeCall(completionHandler: (responseObject: JSON?) -> ()) {
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
        Alamofire.request(.DELETE, GlobalVariables.sharedManager.URL_BASSE+"pets/\(idPet)") .responseJSON { (request, response, responseObject) in
             //              var json:JSON = JSON(responseObject!)
        }
    }
    
    
    
    
    

}