import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['postField', 'postBtn'];

  connect() {
    this.checkIfEmpty();
  }

  checkIfEmpty() {
    if (this.postFieldTarget.value.trim() !== '') {
      this.postBtnTarget.removeAttribute('disabled');
      this.postBtnTarget.classList.remove('cursor-not-allowed');
    } else {
      this.postBtnTarget.setAttribute('disabled', true);
      this.postBtnTarget.classList.add('cursor-not-allowed');
    }
  }
}
