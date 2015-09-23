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
    
    var listaVideo = [Video]()
    
    let textCellIdentifier = "cell"
    
    @IBOutlet weak var tablePet: UITableView!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        
        print("Nosso tipo de pet é : \(self.title)")
        
        
       let xib = UINib(nibName: "PetCell", bundle: nil)
       self.tablePet.registerNib(xib, forCellReuseIdentifier: "cell")
        
     
       // Pega os pets para popular a lista
       pegaListaPetsByTipo()
        
        
        let v1:Video = Video()
        v1.titulo = "Adestrando o veroz"
        v1.urlImage = "http://d38zt8ehae1tnt.cloudfront.net/Best_Pets_Videos_Mookie_and_Matt_Ready_Set_Play_2013__155543.jpg?v=1382936168"
        
        let v2:Video = Video()
        v2.titulo = "Primeiros cuidados"
        v2.urlImage = "http://maxcdn.thedesigninspiration.com/wp-content/uploads/2014/08/Animal-Video-006.jpg"
        
        let v3:Video = Video()
        v3.titulo = "Nào vai dar certo"
        v3.urlImage = "http://www.makeusknow.com/images/funny-dog-video.jpg"
        
        let v4:Video = Video()
        v4.titulo = "To de olho"
        v4.urlImage = "http://www.awesomelycute.com/gallery/2011/11/awesomelycute-video-36.jpg"
        
        self.listaVideo = [v1,v2,v3,v4]
        
    
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.title == "Videos"){
            return self.listaVideo.count
        }else{
            return self.a.count
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(self.title == "Videos"){
            let cell = self.tablePet.dequeueReusableCellWithIdentifier("cell") as! PetCell
            
            let video : Video = self.listaVideo[indexPath.row]
            
            cell.nome.text = video.titulo
            
            loadImageAsync(video.urlImage , imageView: cell.imagePet)
            
            return cell;
            
        }else{
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
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
        
    }
    
    override func prepareForSegue(segue:(UIStoryboardSegue!), sender:AnyObject!)
    {
        if (segue.identifier == "DETALHE")
        {
            print("i set the loading thingy")
           
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func pegaListaPetsByTipo(){
        
        if(self.title==nil){
            self.title = "Cachorro"
        }
        
        ws.getPetsByTipo({retorno in
            
            self.a = retorno!
            
            self.tableView.reloadData()
            
            self.tableView.reloadInputViews()
            
            
            return
        }, tipo: (self.title?.lowercaseString)!)
        
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

