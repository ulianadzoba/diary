import { Controller } from "@hotwired/stimulus";
import { animateCSS } from '../utils';

export default class extends Controller {
  connect() {
    this.element.removeAttribute('hidden');
    animateCSS(this.element, 'fadeIn').then(() => {
      setTimeout(() => {      
        this.dismiss();
      }, 2000);
    });
  }

  dismiss() {    
    animateCSS(this.element, 'fadeOut').then(() => this.element.remove());
  }
}

