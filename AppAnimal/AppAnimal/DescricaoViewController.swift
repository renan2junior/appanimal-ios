//
//  DescricaoViewController.swift
//  AppAnimal
//
//  Created by Renan Junior on 06/10/15.
//  Copyright © 2015 renanjunior. All rights reserved.
//

import UIKit

class DescricaoViewController: UIViewController {

    
    var pet:Pet = Pet()
    
    @IBOutlet weak var fotoPet: UIImageView!
    @IBOutlet weak var nomePet: UILabel!
    @IBOutlet weak var racaPet: UILabel!
    @IBOutlet weak var portePet: UILabel!
    @IBOutlet weak var generoPet: UILabel!
    @IBOutlet weak var idadePet: UILabel!
    @IBOutlet weak var cuidadorPet: UILabel!
    @IBOutlet weak var emailPet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: "backViewTapped:")
        view.addGestureRecognizer(tap)
        
        print(" O pet é \(pet.descricao)")
        
        loadImageAsync(pet.imagem , imageView: fotoPet)
        nomePet.text = pet.pet_nome
        racaPet.text = pet.pet_raca
        portePet.text = pet.pet_porte
        generoPet.text = pet.pet_tipo
        idadePet.text = pet.pet_idade
        cuidadorPet.text = pet.cuidador
        emailPet.text = pet.email
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func backViewTapped(gesture: UIGestureRecognizer) {
        if (gesture.state == UIGestureRecognizerState.Ended) {
            presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func loadImageAsync(stringURL: NSString, imageView: UIImageView, placeholder: UIImage! = nil) {
        imageView.image = placeholder
        
        let url = NSURL(string: stringURL as String)
        let requestedURL = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(requestedURL, queue: NSOperationQueue.mainQueue()) {
            response, data, error in
            
            if data != nil {
                imageView.image = UIImage(data: data!)
            }
        }
    }

    
    

}
