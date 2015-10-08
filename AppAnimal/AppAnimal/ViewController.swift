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

import MediaPlayer


class ViewController: UITableViewController {

    let ws:ClientWS = ClientWS()
    let classeTeste:PetTeste = PetTeste()
    let parse:ParseModels = ParseModels()
    var a : JSON = JSON.null
    var listaVideo = [Video]()
    let textCellIdentifier = "cell"
    
    var videoJSON : JSON = JSON.null
    
    var moviePlayer:MPMoviePlayerController!
    
    @IBOutlet weak var tablePet: UITableView!
    
    override func viewDidLoad() {
       super.viewDidLoad()
       // let p:PetTeste = PetTeste()
       // p.PopulaPet()
        let xib = UINib(nibName: "PetCell", bundle: nil)
       self.tablePet.registerNib(xib, forCellReuseIdentifier: "cell")
        
        let xibVideo = UINib(nibName: "PetVideoCell", bundle: nil)
        self.tablePet.registerNib(xibVideo, forCellReuseIdentifier: "videoCell")
     
       // Pega os pets para popular a lista
       pegaListaPetsByTipo()
        
        pegaListaVideos();

        let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = self.title
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(30.0)
        self.navigationItem.titleView = label
        
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
            let cell = self.tablePet.dequeueReusableCellWithIdentifier("videoCell") as! PetCell
            
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
        if(self.title == "Videos"){
            let videoSelecionado = self.listaVideo[indexPath.row]
            let urlVideo = NSURL(string : videoSelecionado.urlVideo)
            moviePlayer = MPMoviePlayerController(contentURL: urlVideo)
            self.view.addSubview(moviePlayer.view)
            moviePlayer.fullscreen = true
            moviePlayer.play()
        }else{
            let descPet : DescricaoViewController = DescricaoViewController()
            descPet.pet = parse.parsePet(self.a[indexPath.row])
            self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
            self.modalPresentationStyle = .CurrentContext // Display on top of current UIView
            self.presentViewController(descPet, animated: true, completion: nil)            
        }
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
             ws.getPetsByTipo(
                    {retorno in
                   self.a = retorno!
                    self.tableView.reloadData()
                    self.tableView.reloadInputViews()
                    return
        }, tipo: (self.title?.lowercaseString)!)
    }

 
    func pegaListaPets()
        {
            ws.getPets({retorno in
            self.a = retorno!
            self.tableView.reloadData()
            self.tableView.reloadInputViews()
            return
        })
      
    }
    
    func carregaVideos() {
        
        self.listaVideo = parse.parseVideoList(self.videoJSON)
        
       
        
    }
    
    func pegaListaVideos()
    {
        ws.getVideos({retorno in
            self.videoJSON = retorno!
            self.carregaVideos()
            self.tableView.reloadData()
            self.tableView.reloadInputViews()
            return
        })

    }
}

