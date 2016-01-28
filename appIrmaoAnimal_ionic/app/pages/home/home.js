import {Page, NavController, NavParams} from 'ionic/ionic';
import {PetService} from '../services/PetService';
import {PetInfo} from '../pet-info/pet-info';
import {PetForm} from '../pet-form/pet-form';

@Page({
  templateUrl: 'build/pages/home/home.html',
  providers: [PetService]
})
export class HomePage {
  constructor(nav: NavController, navParams: NavParams, petService:PetService) {
    this.nav = nav;
    this.petService = petService;
    this.filter = navParams.get('filter'); 
    if (this.filter != null) {
        console.log('Filter', this.filter.value);
        this.filterPets(this.filter.value);
    } else {
        this.allPets();
    }
    
  }
  
  allPets() {
     this.petService.allPets().subscribe(
        data => {
            this.pets = data; 
        },
        err => this.logError(err),
        () => console.log('Pet all Complete')
     );
  }
  
  filterPets(filter) {
      this.petService.filterPets(filter).subscribe(
        data => {
            this.pets = data; 
        },
        err => this.logError(err),
        () => console.log('Pet filter Complete')
     );
  }
  
  logError(err) {
    console.error('There was an error: ' + err);
  }
   
  itemTapped(event, pet) {
    this.nav.push(PetInfo, {
      pet: pet
    });
  }
  
  btCadTapped() {
    this.nav.push(PetForm);
  }
  
}
