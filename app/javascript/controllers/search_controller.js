import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['input', 'suggestions', 'hiddenCategoryId'];

  connect() {
    document.addEventListener('click', (event) => {
      if (!this.element.contains(event.target)) {
        this.hideSuggestions();
      }
    });
  }

  suggestions() {
    const query = this.inputTarget.value;
    const url = this.element.dataset.suggestionsUrl;
    const category_id = this.hiddenCategoryIdTarget.value;

    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.requestSuggestions(query, category_id, url);
    }, 250);
  }

  requestSuggestions(query, category_id, url) {
    if (query.length === 0) {
      this.hideSuggestions();
      return;
    }
    this.showSuggestions();

    fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content,
      },
      body: JSON.stringify({ query: query, category_id: category_id }),
    }).then((response) => {
      response.text().then((html) => {
        document.body.insertAdjacentHTML('beforeend', html);
      });
    });
  }

  childClicked(e) {
    this.childWasClicked = this.element.contains(e.target);
  }

  showSuggestions() {
    this.suggestionsTarget.classList.remove('hidden');
  }

  hideSuggestions() {
    if (!this.childWasClicked) {
      this.suggestionsTarget.classList.add('hidden');
    }
    this.childWasClicked = false;
  }
  
  clearInput(e) {
    this.inputTarget.value = '';
    Turbo.navigator.submitForm(this.element);
  }
}