import {Inject} from 'angular2/core';
import { Http, Headers } from 'angular2/http';
import 'rxjs/add/operator/map';

export class PetService {
    
    constructor(@Inject(Http) http: Http) {
        this.http = http
    }  
    
    allPets(): Observable<> {
        var url = 'http://pet.brittus.com/pets/';
        this.response = this.http.get(url).map(res => res.json());
      return this.response;
    }
    
    filterPets(filter): Observable<> {
        var url = 'http://pet.brittus.com/pets/tipo/' + filter;
        this.response = this.http.get(url).map(res => res.json());
      return this.response;
    }
    
    savePet(pet, img64): Observable<> {
       console.log(pet.petNome);
       
       console.log('Imagem 64: ', img64);
       
       let body = JSON.stringify({
             pet_nome: pet.petNome
            ,pet_sexo: pet.petSexo
            ,pet_idade: pet.petIdade
            ,pet_descricao: pet.petDescricao
            ,pet_tipo_idade: pet.petTipoIdade
            ,pet_porte: pet.petPorte
            ,pet_raca: pet.petRaca
            ,pet_tipo: pet.petTipo
            ,pet_status: ''
            ,pet_endereco : pet.petEndereco
            ,cuidador: pet.cuidador
            ,email: pet.email
            ,telefone: pet.telefone
            //,imagem: 'https://s3-sa-east-1.amazonaws.com/irmaoanimal/animais/animal_1427678338547.jpg'
            ,imagemBase64: img64
       });
       
       let headers = new Headers();
       headers.append('Content-Type', 'application/json');
       
       let url = 'http://pet.brittus.com/pets/';
       this.response = this.http.post(url, body, {headers: headers}).map(res => res.json());   
       console.log('Resp ', this.response);  
       return this.response;    
    }
    
}