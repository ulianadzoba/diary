import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];

  toggleVisibility(e) {
    let target = e.currentTarget;
    target.querySelector('.visibility-off').classList.toggle('hidden');
    target.querySelector('.visibility-on').classList.toggle('hidden');

    if (this.inputTarget.type === 'password') {
      this.inputTarget.type = 'text';
    } else {
      this.inputTarget.type = 'password';
    }
  }
}

