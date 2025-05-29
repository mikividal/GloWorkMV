import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  clear(event) {
    event.preventDefault(); // Prevent default form behavior
    this.inputTarget.value = ""; // Clear text field
  }

  reset() {
    this.inputTarget.value = ""; // Ensures input clears on Turbo update
  }
}
