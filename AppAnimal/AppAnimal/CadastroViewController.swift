//
//  CadastroViewController.swift
//  AppAnimal
//
//  Created by Bruno Brito on 22/08/15.
//  Copyright (c) 2015 renanjunior. All rights reserved.
//

import UIKit
import AWSS3

class CadastroViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet var imgPet: UIImageView!
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var tfIdade: UITextField!
    @IBOutlet weak var tfTipoIdade: UITextField!
    @IBOutlet weak var tfGenero: UITextField!
    @IBOutlet weak var tfTipo: UITextField!
    @IBOutlet weak var tfPorte: UITextField!
    @IBOutlet weak var tfRaca: UITextField!
    @IBOutlet weak var tfCuidador: UITextField!
    @IBOutlet weak var tfTelefone: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tvDesc: UITextView!
    
    
    var pickerView:UIPickerView!
    var pickerViewGenero:UIPickerView!
    var pvTipo:UIPickerView!
    var pvPorte:UIPickerView!
    
    var pickTipoIdade = ["ano", "mês", "dia"]
    var pickGenero = ["fêmea", "macho"]
    var pickTipo = ["cachorro", "gato", "passaro", "outros"]
    var pickPorte = ["pequeno", "médio", "grande"]
    
    var clienteWS:ClientWS!
    var pet:Pet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker.delegate = self
        
        let error = NSErrorPointer()
        do {
            try NSFileManager.defaultManager().createDirectoryAtPath(
                        NSTemporaryDirectory().stringByAppendingString("upload"),
                        withIntermediateDirectories: true,
                        attributes: nil)
        } catch let error1 as NSError {
            error.memory = error1
                print("Creating 'upload' directory failed. Error: \(error)")
        }
        
        self.pickerView = UIPickerView()
        self.pickerView.tag = 0
        self.pickerView.delegate = self
        
        self.pickerViewGenero = UIPickerView()
        self.pickerViewGenero.tag = 1
        self.pickerViewGenero.delegate = self
        
        self.pvTipo = UIPickerView()
        self.pvTipo.tag = 2
        self.pvTipo.delegate = self
        
        self.pvPorte = UIPickerView()
        self.pvPorte.tag = 3
        self.pvPorte.delegate = self
        
        self.tfTipoIdade.inputView = self.pickerView
        self.tfGenero.inputView = self.pickerViewGenero
        self.tfTipo.inputView = self.pvTipo
        self.tfPorte.inputView = self.pvPorte
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    @IBAction func uploadImagem(sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
     }
    
    @IBAction func salvar(sender: AnyObject) {
         AWSServices.upload(self.imgPet.image!, callback: { (urlImagem: String, error: NSError!) in
             if (error != nil) {
                Alerta.alerta("Erro ao fazer upload da imagem! Error: " + error.description, viewController: self)
            } else {
                
                self.pet = Pet()
                self.pet.pet_nome = self.tfNome.text
                self.pet.pet_idade = self.tfIdade.text
                self.pet.pet_tipo_idade = self.tfTipoIdade.text
                self.pet.pet_genero  = self.tfGenero.text
                self.pet.pet_raca = self.tfRaca.text
                self.pet.pet_tipo = self.tfTipo.text
                self.pet.pet_porte = self.tfPorte.text
                self.pet.imagem = urlImagem
                self.pet.pet_descricao = self.tvDesc.text
                
                self.pet.cuidador = self.tfCuidador.text
                self.pet.email = self.tfEmail.text
                self.pet.telefone = self.tfTelefone.text
                self.pet.descricao = "-"
                
                print(self.pet.getString())
                
                self.clienteWS = ClientWS()
                self.clienteWS.postPet(self.pet)
                
                Alerta.alerta("Dados salvos com sucesso!", viewController: self)
                
                self.tfNome.text = ""
                self.tfIdade.text = ""
                self.tfRaca.text = ""
                self.tfCuidador.text = ""
                self.tfTelefone.text = ""
                self.tvDesc.text = ""
                self.tfEmail.text = ""
                self.imgPet.image = UIImage(named: "pets")
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
                var destViewController : UIViewController
                
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ControllerPrincipal")
                destViewController.title = "Passaro"

             }
        })
     }
    
    
    //Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = (info as NSDictionary).objectForKey(UIImagePickerControllerOriginalImage) as! UIImage
        self.imgPet.image = image
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if (pickerView.tag == 0) {
            return pickTipoIdade.count
        } else if (pickerView.tag == 1) {
            return pickGenero.count
        } else if (pickerView.tag == 2) {
            return pickTipo.count
        } else if (pickerView.tag == 3) {
            return pickPorte.count
        } else {
            return 1
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView.tag == 0) {
            return pickTipoIdade[row]
        } else if (pickerView.tag == 1) {
            return pickGenero[row]
        } else if (pickerView.tag == 2) {
            return pickTipo[row]
        } else if (pickerView.tag == 3) {
            return pickPorte[row]
        } else {
            return ""
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView.tag == 0) {
            tfTipoIdade.text = pickTipoIdade[row]
            tfTipoIdade.resignFirstResponder()
        } else if (pickerView.tag == 1) {
            tfGenero.text = pickGenero[row]
            tfGenero.resignFirstResponder()
        } else if (pickerView.tag == 2) {
            tfTipo.text = pickTipo[row]
            tfTipo.resignFirstResponder()
        } else if (pickerView.tag == 3) {
            tfPorte.text = pickPorte[row]
            tfPorte.resignFirstResponder()

        }
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        tfNome.resignFirstResponder()
        tfIdade.resignFirstResponder()
        tfRaca.resignFirstResponder()
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
