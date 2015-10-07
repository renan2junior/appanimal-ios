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
     
        let pet:Pet = Pet()
        pet.descricao = json["pet_descricao"].stringValue
        pet.cuidador = json["cuidador"].stringValue
        pet.email = json["email"].stringValue
        pet.imagem = json["imagem"].stringValue
        pet.pet_nome = json["pet_nome"].stringValue
        pet.pet_raca = json["pet_raca"].stringValue
        pet.pet_porte = json["pet_porte"].stringValue
        pet.pet_tipo = json["pet_tipo"].stringValue
        pet.pet_idade = json["pet_idade"].stringValue
        return pet
    }
    
    func parsePetLis(json:JSON)->Array<Pet>{
        var pets = Array<Pet>()
        for(var x = 0 ; x<=json.count; x++){
            let pet = parsePet(json[x])
            pets.append(pet)
        }
        return pets
    }
    
    func parseVideo(json:JSON)->Video {
        
        let video:Video = Video()
        video.titulo = json["titulo"].stringValue
        video.urlImage = json["urlImagem"].stringValue
        video.urlVideo = json["urlVideo"].stringValue
        
        return video
        
    }
    
    func parseVideoList(json:JSON)->Array<Video>{
        var videos = Array<Video>()
        for(var x = 0 ; x<json.count; x++){
            let video = parseVideo(json[x])
            videos.append(video)
        }
        return videos
    }

}
