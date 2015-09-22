//
//  PetTeste.swift
//  AppAnimal
//
//  Created by Renan Junior on 17/09/15.
//  Copyright (c) 2015 renanjunior. All rights reserved.
//

import Foundation

import Alamofire



class PetTeste{
    
     let ws:ClientWS = ClientWS()
    
    
    func PopulaPet(){
    
        // Popula Caes
        
        var nome = ["Toto","Rex","Tiao","Mana","Sofia","Tor","Romario","Pele"]
        
       
        
        var descricao = ["Quieto","Levado","Agitado","Docil","Dorminhoco","Agitado","Levado","Carinhoso"]
        
        var foto_cao = ["http://wallpaper.ultradownloads.com.br/45586_Papel-de-Parede-Filhote-de-Cachorro_1024x768.jpg",
                        "http://image.cachorrogato.com.br/textimages/Cachorro%20chorando%2001.jpg",
                        "http://tudosobrecachorros.com.br/wp-content/uploads/escolher.png",
                        "http://t2.uccdn.com/pt/images/8/7/2/img_como_evitar_que_o_meu_cachorro_solte_tanto_pelo_6278_orig.jpg",
                        "http://wallpaper.ultradownloads.com.br/105712_Papel-de-Parede-Cachorro-Songshi-Quan_1024x768.jpg",
                        "http://www.imagenswiki.com/Uploads/imagenswiki.com/ImagensGrandes/cachorro-beagle.jpg",
                        "http://info.abril.com.br/images/materias/2014/02/thumbs/thumb-32768160227-cachorro-resized.jpg",
                        "http://vejasp.abril.com.br/blogs/bichos/files/2015/03/Cachorro-magro.jpg"]
        
        var foto_gato = ["http://www.clinicavetmed.com.br/site/wp-content/uploads/2014/10/Los-gatos-nos-ignoran-1.jpg",
            "http://www.fondox.net/wallpapers/un-gato-bebe-433.jpg",
            "http://www.pet-palace.mx/imagenes/BlogNotas/indoorcat.png",
            "http://www.veterinariaportalmayor.cl/wp-content/uploads/2013/12/Curar-una-herida-a-un-gato.jpg",
            "http://www.gatosdomesticos.com/wp-content/uploads/2010/03/morris-cat.jpg",
            "http://www.mensagenscomamor.com/images/jpgs/img/g/gato_cinza_branco.jpg",
            "http://s2.glbimg.com/1AW8S_APqsxu21FFr0kc_25RKNQ=/e.glbimg.com/og/ed/f/original/2014/02/12/gato03.jpg",
            "http://mazarine.com.br/wp-content/uploads/2013/12/gatinho.jpg"]
        
        
        for var x = 0 ; x < nome.count; ++x{
        
            var cao:Pet = Pet()
            
            cao.cuidador = "Renan" //cuidador[x]
            cao.descricao = descricao[x]
            cao.email = "teste@gmail.com"
            cao.pet_descricao = descricao[x]
            cao.pet_idade = "\(x)"
            cao.pet_nome = nome[x]
            cao.pet_porte = "Grande"
            cao.pet_raca = "VL"
            cao.pet_tipo = "cachorro"
            cao.pet_tipo_idade = "anos"
            cao.telefone = "11111-111111"
            cao.imagem = foto_cao[x]
            
            ws.postPet(cao)
            
           
            cao = Pet()
            
            cao.cuidador = "Renan" //cuidador[x]
            cao.descricao = descricao[x]
            cao.email = "teste@gmail.com"
            cao.pet_descricao = descricao[x]
            cao.pet_idade = "\(x)"
            cao.pet_nome = nome[x]
            cao.pet_porte = "Grande"
            cao.pet_raca = "VL"
            cao.pet_tipo = "gato"
            cao.pet_tipo_idade = "anos"
            cao.telefone = "11111-111111"
            cao.imagem = foto_gato[x]
            
            ws.postPet(cao)
            
            cao = Pet()
            
            cao.cuidador = "Renan" //cuidador[x]
            cao.descricao = descricao[x]
            cao.email = "teste@gmail.com"
            cao.pet_descricao = descricao[x]
            cao.pet_idade = "\(x)"
            cao.pet_nome = nome[x]
            cao.pet_porte = "Grande"
            cao.pet_raca = "VL"
            cao.pet_tipo = "passaro"
            cao.pet_tipo_idade = "anos"
            cao.telefone = "11111-111111"
            cao.imagem = foto_cao[x]
            
            ws.postPet(cao)
            
            cao = Pet()
            
            cao.cuidador = "Renan" //cuidador[x]
            cao.descricao = descricao[x]
            cao.email = "teste@gmail.com"
            cao.pet_descricao = descricao[x]
            cao.pet_idade = "\(x)"
            cao.pet_nome = nome[x]
            cao.pet_porte = "Grande"
            cao.pet_raca = "VL"
            cao.pet_tipo = "outros"
            cao.pet_tipo_idade = "anos"
            cao.telefone = "11111-111111"
            cao.imagem = foto_cao[x]
            
            ws.postPet(cao)


            
        }
        
    
        
            
            
            
        
        
        
        
    }
    
    
    func deletaPets(){
        
        
        
    }
    
    
    
    
}