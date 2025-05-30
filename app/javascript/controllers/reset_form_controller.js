import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.element.addEventListener("turbo:submit-end", () => {
      this.clear(); // Ensures input resets when Turbo finishes processing
    });
  }

  clear() {
    this.inputTarget.value = ""; // Clears the text box immediately
  }

  reset() {
    this.inputTarget.value = ""; // Clears input field after Turbo updates
  }
}
