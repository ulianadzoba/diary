import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];

  connect(e) {
    if (!this.backdrop) {
      document.body.insertAdjacentHTML('beforeend', '<div modal-backdrop="" class="fixed inset-0 z-40 bg-gray-900 bg-opacity-50 dark:bg-opacity-80"></div>');
    }
  }

  hideModal() {
    this.element.parentElement.removeAttribute("src");

    this.modalTarget.remove();
    this.backdrop.remove();

    location.reload(); //temporarily tinymce init
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.hideModal();
    }
  }

  closeWithKeyboard(e) {
    if (e.code == "Escape") {
      this.hideModal();
    }
  }

  get backdrop() {
    return document.querySelector('[modal-backdrop]');
  }
}
