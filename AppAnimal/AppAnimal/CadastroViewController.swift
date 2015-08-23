//
//  CadastroViewController.swift
//  AppAnimal
//
//  Created by Bruno Brito on 22/08/15.
//  Copyright (c) 2015 renanjunior. All rights reserved.
//

import UIKit
import AWSS3

class CadastroViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imgPet: UIImageView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker.delegate = self
        
        var error = NSErrorPointer()
        if !NSFileManager.defaultManager().createDirectoryAtPath(
            NSTemporaryDirectory().stringByAppendingPathComponent("upload"),
            withIntermediateDirectories: true,
            attributes: nil,
            error: error) {
                println("Creating 'upload' directory failed. Error: \(error)")
        }

        
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
                
                Alerta.alerta("Imagem enviada", viewController: self)
                
                var pet = Pet(descricao: "teste")
                pet.imagem = urlImagem
                pet.descricao = "teste"
                pet.email = "a@a.com"
                pet.cuidador = "Joao"
                
            }
        })
        
        
    }
    
    
    //Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = (info as NSDictionary).objectForKey(UIImagePickerControllerOriginalImage) as! UIImage
        self.imgPet.image = image
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
