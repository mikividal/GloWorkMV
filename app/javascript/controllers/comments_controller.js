import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["comments"]

  toggle() {
    this.commentsTarget.classList.toggle("hidden")
  }
}
