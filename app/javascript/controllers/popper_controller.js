import { Controller } from "@hotwired/stimulus";
import { createPopper } from "@popperjs/core";

export default class extends Controller {
  static targets = ['element', 'tooltip'];
  static values = {
    placement: { type: String, default: 'top' },
    offset: { type: Array, default: [0, 8] },
  };

  connect() {
    this.popperInstance = createPopper(this.elementTarget, this.tooltipTarget, {
      placement: this.placementValue,
      modifiers: [
        {
          name: 'offset',
          options: {
            offset: this.offsetValue,
          },
        },
      ],
    });
  }

  show(event) {
    this.tooltipTarget.setAttribute('data-show', '');
    this.popperInstance.update();
  }

  hide(event) {
    this.tooltipTarget.removeAttribute('data-show');
  }

  disconnect() {
    if (this.popperInstance) this.popperInstance.destroy();
  }
}