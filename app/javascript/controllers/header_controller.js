import { Controller } from "@hotwired/stimulus";
import { useClickOutside } from 'stimulus-use';

export default class extends Controller {
  static targets = ['dropdown'];

  connect() {
    useClickOutside(this);
  }

  toggleDropdown(event) {
    this.dropdownTargets.forEach((element) => {
      if(!event.currentTarget.contains(element) && !element.classList.contains('hidden')) element.classList.add('hidden');
      if(event.currentTarget.contains(element)) element.classList.toggle('hidden');
    })
  }

  closeDropdown(event) {
    event.preventDefault();
    this.dropdownTargets.forEach((element) => {
      if(!element.classList.contains('hidden')) element.classList.add('hidden');
    })
  }
}

