//
//  ViewController.swift
//  AppAnimal
//
//  Created by renanjunior on 04/08/15.
//  Copyright (c) 2015 renanjunior. All rights reserved.
//

import UIKit

import SwiftyJSON

import Alamofire


class ViewController: UITableViewController {

    let ws:ClientWS = ClientWS()
    
    let classeTeste:PetTeste = PetTeste()
    
    let parse:ParseModels = ParseModels()
    
    var a : JSON = JSON.null
    
    let textCellIdentifier = "cell"
    
    @IBOutlet weak var tablePet: UITableView!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
       let xib = UINib(nibName: "PetCell", bundle: nil)
       self.tablePet.registerNib(xib, forCellReuseIdentifier: "cell")
        
     
       // Pega os pets para popular a lista
       pegaListaPets()
        
       
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.a.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let pet : Pet = parse.parsePet(self.a[indexPath.row])
        
        debugPrint(" Cuidador : \(pet.cuidador) - \(pet.pet_descricao) - \(pet.pet_nome)", terminator: "")

        let cell = self.tablePet.dequeueReusableCellWithIdentifier("cell") as! PetCell
        
        
        if(pet.cuidador == nil){
            pet.cuidador = "Vazio"
        }
        
        if(pet.pet_descricao == nil){
            pet.pet_descricao = pet.descricao
        }
        
        
        cell.nome.text = pet.pet_nome
              
        loadImageAsync(pet.imagem, imageView: cell.imagePet)
        
        return cell
    
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
      self.performSegueWithIdentifier("TelaDetalhe", sender: indexPath);
        
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 
    func pegaListaPets(){
        
        ws.getPets({retorno in
            
            self.a = retorno!
            
            self.tableView.reloadData()
            
            self.tableView.reloadInputViews()
        
           
            return
        })
      
    }
    
    
   

}

