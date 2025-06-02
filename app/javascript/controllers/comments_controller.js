import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["comments", "form"]

  toggle() {
  this.commentsTarget.classList.toggle("hidden");
  this.formTarget.classList.toggle("hidden");
}
}
