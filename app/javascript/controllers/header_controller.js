import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dropdown"];

  toggleDropdown(e) {
    this.dropdownTarget.classList.toggle('hidden');
  }
}
