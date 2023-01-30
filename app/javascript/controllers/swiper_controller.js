import { Controller } from "@hotwired/stimulus";
import { Swiper, FreeMode, Pagination, Navigation } from 'swiper';

Swiper.use([FreeMode, Pagination, Navigation])

export default class extends Controller {
  static values = {
    options: Object
  }

  connect(e) {
    this.swiper = new Swiper(this.element, {
      ...this.defaultOptions,
      ...this.optionsValue
    });
  }

  disconnect() {
    this.swiper.destroy()
    this.swiper = undefined
  }

  get defaultOptions() {
    return {}
  }
}
