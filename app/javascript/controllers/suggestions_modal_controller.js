import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="suggestions-modal"
export default class extends Controller {
  static targets = ["form", "actionedField"]

  connect() {
    this.modal = document.getElementById("confirmModal")
    if (!this.modal) return

    this.modal.addEventListener("show.bs.modal", (event) => {
      const button = event.relatedTarget
      const suggestionId = button.getAttribute("data-suggestion-id")
      const actioned = button.getAttribute("data-actioned")

      this.formTarget.action = `/suggestions/${suggestionId}`
      this.actionedFieldTarget.value = actioned
    })
  }
}
