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


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let ws:ClientWS = ClientWS()
    
    let list_pets = [
        Pet(descricao:"Totoffffffffffffffffffffffff"), Pet(descricao:"rghhhgdjhsfabdjkhfasjfbasnbnsbafnbasex")
    ]
    
    
    
    let textCellIdentifier = "cell"
    
    
    @IBOutlet weak var tablePet: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // pegaPetByID()
        
        //tablePet.reloadData()
        
       
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list_pets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = self.tablePet.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PetCell
        
        
        let row = indexPath.row
       
        
        let desc:String = list_pets[row].descricao!
        
        
        cell.nome.text = desc
        
        
        
        return cell    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
   
    func pegaDados2(){
        
        let retorno2 = ws.GetPets2()
        
        debugPrint(retorno2)
       
        
    }
    
    func pegaListaPets(){
        
        ws.getPets({retorno, erro in
        
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

