import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['notif'];

  connect() {
    setTimeout(() => {
      this.notifTarget.classList.add('opacity-0');
    }, 2000);
  }
}
