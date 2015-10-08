//
//  MapaPet.swift
//  AppAnimal
//
//  Created by Renan Junior on 22/09/15.
//  Copyright © 2015 renanjunior. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class MapaPet : UIViewController, CLLocationManagerDelegate {
    
    var locManager = CLLocationManager()
    var parse = ParseModels()
    let ws:ClientWS = ClientWS()
    var jsonPet : JSON = JSON.null
    
    @IBOutlet var mapView: MKMapView!
    
    var pin = MKPointAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = self.title
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(30.0)
        self.navigationItem.titleView = label

        self.locManager.requestWhenInUseAuthorization()
        
    }
    
    func marcaPinsMapa() {
        
        
        //let endereco = "Rua Domingos Ferreira - Copacabana, Rio de Janeiro - RJ"
        
        
        ws.getPets({retorno in
            self.jsonPet = retorno!
            
            let pets = self.parse.parsePetLis(self.jsonPet)
            
            for pet in pets {
                
                if !pet.pet_endereco.isEmpty  {
                    
                    let endereco = pet.pet_endereco
                    let geoCoder = CLGeocoder()
                    
                    geoCoder.geocodeAddressString(endereco) { (placemarks, error) -> Void in
                        
                        if let firstPlacemark = placemarks?[0] {
                            
                            let coordinates:CLLocationCoordinate2D = firstPlacemark.location!.coordinate
                            let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01 , 0.01)
                            let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinates, span)
                            
                            let pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                            pointAnnotation.coordinate = coordinates
                            pointAnnotation.title = pet.pet_nome
                            pointAnnotation.subtitle = pet.pet_endereco
                            
                            self.mapView.addAnnotation(pointAnnotation)
                            self.mapView.centerCoordinate = coordinates
                            self.mapView.setRegion(region, animated: true)
                            self.mapView.selectAnnotation(pointAnnotation, animated: true)
                            
                        }
                    }
                    
                }
                
            }

            
            
            return
        })
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Inicia o LocationManager para monitorar as coordenadas GPS
        self.locManager.delegate = self
        self.locManager.distanceFilter = 100.00
        self.locManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        //Comeca a monitorar o GPS
        self.locManager.startUpdatingLocation()
        
        marcaPinsMapa()
    }
    
    deinit {
        self.locManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Última localização CLLocation
        let newLocation = locations[locations.count-1] as CLLocation
        
        let lat = newLocation.coordinate.latitude
        let lng = newLocation.coordinate.longitude
        
        print("didUpdateToLocation lat:\(lat), lng:\(lng)")
        
        //        let distancia = newLocation.distanceFromLocation(oldLocation)
        //        println("Distância em metros:\(distancia)")
        
        // Coordenada (latitude/longitude)
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        print(center)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location = MKCoordinateRegion(center: center, span: span)
        
        // Centraliza o mapa nesta coordenada
        self.mapView.setRegion(location, animated: true)
        
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    

    
}