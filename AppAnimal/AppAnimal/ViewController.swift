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
    
    let list_pets = [
        Pet(descricao:"Totoffffffffffffffffffffffff"), Pet(descricao:"rghhhgdjhsfabdjkhfasjfbasnbnsbafnbasex")
    ]
    
    var a : NSArray = []
    
    let textCellIdentifier = "cell"
    
    
    @IBOutlet weak var tablePet: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       pegaListaPets()
        
       
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.a.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        var cuidador:String = self.a[indexPath.row]["cuidador"] as! String
        
        
        debugPrint(" Cuidador : \(cuidador)")

        
   /*
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = cuidador
        
     */
        
       
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PetCell
        
        
        cell.nome.text = "dfsjkhajkds"
        
        
    
        
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

