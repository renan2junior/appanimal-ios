import { Page, NavController, Platform } from 'ionic/ionic';
import { Component } from 'angular2/core';  
import { FORM_DIRECTIVES, FormBuilder,  ControlGroup, Validators, AbstractControl } from 'angular2/common';
import { PetService } from '../services/PetService';
import { PetInfo } from '../pet-info/pet-info';
import { HomePage } from '../home/home';
 
@Page({
    templateUrl: 'build/pages/pet-form/pet-form.html',
    directives: [FORM_DIRECTIVES],
    providers: [PetService]
})
export class PetForm {
    
    form: ControlGroup;   
    petNome: AbstractControl;
    petSexo: AbstractControl;
    petIdade: AbstractControl;
    petDescricao: AbstractControl;
    petTipoIdade: AbstractControl;
    petPorte: AbstractControl;
    petRaca: AbstractControl;
    petTipo: AbstractControl;
    petEndereco: AbstractControl;
    cuidador: AbstractControl;
    email: AbstractControl;
    telefone: AbstractControl;
    
    constructor(nav: NavController, fb: FormBuilder, petService:PetService, platform: Platform) {
        this.platform = platform;
        this.nav = nav;
        this.form = fb.group({
             'petNome': ['', Validators.required], 
             'petSexo': [''],
             'petIdade': [''],
             'petDescricao': [''],
             'petTipoIdade': [''],
             'petPorte': [''],
             'petRaca': [''],
             'petTipo': [''],
             'petEndereco': [''],
             'cuidador': [''],
             'email': [''],
             'telefone': ['']
        });
        
        this.petService = petService;
        this.petNome = this.form.controls['petNome'];
        this.petSexo = this.form.controls['petSexo'];
        this.petIdade = this.form.controls['petIdade'];
        this.petDescricao = this.form.controls['petDescricao'];
        this.petTipoIdade = this.form.controls['petTipoIdade'];
        this.petPorte = this.form.controls['petPorte'];
        this.petRaca = this.form.controls['petRaca'];
        this.petTipo = this.form.controls['petTipo'];
        this.petEndereco = this.form.controls['petEndereco'];
        this.cuidador = this.form.controls['cuidador'];
        this.email = this.form.controls['email'];
        this.telefone = this.form.controls['telefone'];
       
    }
    
    onSubmit(value: string): void { 
        
        if(this.form.valid) {
            
            var image = document.getElementById('petFoto');
            
            this.petService.savePet(value, image.src).subscribe(
                data => {
                    this.pet = data;
                    
                    this.nav.popToRoot();
                    this.nav.push(PetInfo, {
                        pet: this.pet
                    });                     
                },
                err => console.log('Error add', err),
                () => console.log('Pet add Complete')
            );
            
            console.log('ok');
        } else {
            console.log('Error add');
        }
    } 
    
    getPhoto(event) {        
 
        var options = {
            quality: 30,
            destinationType: navigator.camera.DestinationType.DATA_URL,
            sourceType: navigator.camera.PictureSourceType.CAMERA,
            cameraDirection: 1,
            saveToPhotoAlbum: false
        };
        
        this.takePicture(options);
            
    }
    
    getPicture(event) {
        var options = {
            quality: 30,
            destinationType: navigator.camera.DestinationType.DATA_URL,
            sourceType: navigator.camera.PictureSourceType.PHOTOLIBRARY,
            cameraDirection: 1,
            saveToPhotoAlbum: false
        };
        
        this.takePicture(options);
    }
    
    takePicture(options) {
        
        var img = document.getElementById('petImg');
        img.style.display = 'none';
        
        this.platform.ready().then(() => { 
            
            navigator.camera.getPicture(onSuccess, onFail, options);
            
            function onSuccess(imageData) {
                var image = document.getElementById('petFoto');
                image.src = "data:image/jpeg;base64," + imageData;
                this.imageBase64 = imageData;
                console.log(this.imageBase64);                
            }

            function onFail(message) {
                alert('Erro: ' + message);
            }
            
        });
        
    }
    
}