import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['menu'];

  connect() {
    window.addEventListener('click', (e) => {
      if (!e.target.classList.contains('navbar-menu')) {
        this.hideMenu();
      }
    });
  }

  toggleMenu() {
    this.menuTarget.classList.toggle('hidden');
  }

  hideMenu() {
    if (!this.menuTarget.classList.contains('hidden')) {
      this.menuTarget.classList.add('hidden');
    }
  }
}
