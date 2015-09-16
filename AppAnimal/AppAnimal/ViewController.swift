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
    
    
   
    

    
    
    let parse:ParseModels = ParseModels()
    
    
    var a : JSON = JSON.nullJSON
    
    let textCellIdentifier = "cell"
    
    
    @IBOutlet weak var tablePet: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var xib = UINib(nibName: "PetCell", bundle: nil)
        self.tablePet.registerNib(xib, forCellReuseIdentifier: "cell")
        
        // Criando um novo Pet
        // OBS : POR ENQUANTO TEM QUE PREENCHER O OBJETO TODO
        var p = Pet()
        p.pet_nome="Renan"
        //ws.postPet(p)
        
        
       pegaListaPets()
        
       
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.a.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var pet : Pet = parse.parsePet(self.a[indexPath.row])
        
        debugPrint(" Cuidador : \(pet.cuidador)")

        
        var cell = self.tablePet.dequeueReusableCellWithIdentifier("cell") as! PetCell
        
        
        if(pet.cuidador == nil){
            pet.cuidador = "Vazio"
        }
        
        cell.nome.text = pet.cuidador
        
        
        return cell
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
   
    func pegaDados2(){
        
        let retorno2 = ws.GetPets2()
        
        debugPrint(retorno2)
       
        
    }
    
    func pegaListaPets(){
        
        ws.getPets({retorno, erro in
            
            self.a = retorno!
            
            self.tableView.reloadData()
        
            println("Retorno \(retorno); erro = \(erro)")
            return
        })
        
    }
    
    
    func pegaPetByID(){
        
        ws.getPet("1", completionHandler: {retorno, erro in
            
            var pet:Pet = retorno
            
            println("Retorno \(retorno); Erro = \(erro)")
            return
        } )
    }
    


}

