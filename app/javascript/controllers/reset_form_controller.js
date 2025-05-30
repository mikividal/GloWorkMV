import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  clear() {
    this.inputTarget.value = ""; // Clears the text box immediately
  }

  connect() {
    this.element.addEventListener("turbo:submit-end", () => this.clear());
  }
}
