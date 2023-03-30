import { Controller } from '@hotwired/stimulus';
import _ from 'lodash';

export default class extends Controller {
  static targets = ['content', 'readingTime'];

  connect(e) {
    this.readingTime();
  }

  readingTime() {
    const content = this.contentTarget.textContent;
    const wordsPerMinute = 265;
    const numberOfWords = content.split(/\s/g).length;
    const estimatedTimeInMinutes = _.ceil(numberOfWords/wordsPerMinute);
    this.readingTimeTarget.textContent = `${estimatedTimeInMinutes} min read`
  }
}
