import {App, IonicApp, Platform, Config} from 'ionic/ionic';
import {HomePage} from './pages/home/home';

@App({
  templateUrl: 'build/app.html'
})
export class MyApp {
  constructor(app: IonicApp, platform: Platform) {
    this.app = app;
    this.platform = platform;
    this.initializeApp();
    
    this.filters = [
        { title: 'Cachorro', value: 'cachorro' },
        { title: 'Gato', value: 'gato' },
        { title: 'Pássaro', value: 'passaro' },
        { title: 'Outros', value: 'outros' }
    ];
    
    this.rootPage = HomePage;
  }

  initializeApp() {
    this.platform.ready().then(() => {
      console.log('Platform ready');
    });
    
    if (window.StatusBar) {
       window.StatusBar.styleDefault();
    }
  }
  
  filterPets(filter) {
      // close the menu when clicking a link from the menu
    this.app.getComponent('leftMenu').close();
    let nav = this.app.getComponent('nav');
    nav.push(HomePage, {
      filter: filter
    });
    nav.setRoot(HomePage);
  }
 
}
