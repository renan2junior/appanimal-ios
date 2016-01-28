import {IonicApp, Page, NavController, NavParams, Platform} from 'ionic/ionic';
 
@Page({
  templateUrl: 'build/pages/pet-info/pet-info.html'
})
 
export class PetInfo {
  constructor(app: IonicApp, nav: NavController, navParams: NavParams, platform: Platform) {
    this.nav = nav;
    this.pet = navParams.get('pet'); 
    this.platform = platform;    
    document.getElementById('map_canvas').innerHTML = "";
    document.getElementById('map_canvas').style.display = 'none';
    //this.initializeMap(this.pet);    
  }
  
  initializeMap(pet) {
      
    console.log('Hello', document.getElementById('map_canvas'));

    this.platform.ready().then(() => {
        
        this.div = document.getElementById('map_canvas');
        this.div.style.display = 'block';
        var minZoomLevel = 16;
 
        this.map = new google.maps.Map(this.div, {
            zoom: minZoomLevel,
            center: new google.maps.LatLng(38.50, -90.50),
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });
        
        this.geocoder = new google.maps.Geocoder();
            
        geocodeAddress(this.geocoder, this.map);
        
        function geocodeAddress(geocoder, resultsMap) {
            geocoder.geocode({'address': pet.pet_endereco}, function(results, status) {
                if (status === google.maps.GeocoderStatus.OK) {
                    resultsMap.setCenter(results[0].geometry.location);
                    this.marker = new google.maps.Marker({
                        map: resultsMap,
                        position: results[0].geometry.location
                    });
                } else {
                    alert('Geocode was not successful for the following reason: ' + status);
                }
            });
        }
        
    });
  }
  
}