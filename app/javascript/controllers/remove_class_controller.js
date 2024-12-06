import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove-class"
export default class extends Controller {
  static targets = ["inputElementEmail"];

  connect() {
    this.inputElementEmailTarget.classList.remove("is-valid");
  }
}
