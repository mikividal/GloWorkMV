import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "showTeamBtn",
    "showOwnBtn",
    "teamSection",
    "personalSection",
    "moodCards",
    "moodCard",
    "teamPanel"
  ]

  connect() {
    if (this.hasShowTeamBtnTarget && this.hasShowOwnBtnTarget) {
      this.showTeamBtnTarget.addEventListener("click", () => this.showTeamMood())
      this.showOwnBtnTarget.addEventListener("click", () => this.showOwnMood())
    }

    this.element.addEventListener("click", (e) => {
      const memberCard = e.target.closest(".member-card")
      if (memberCard) {
        const userId = memberCard.getAttribute("data-user-id")
        this.loadUserMood(userId)
      }
    })
  }

  loadUserMood(userId) {
    fetch(`/moodtrackers/user_mood_panel/${userId}`, {
      headers: { "Accept": "text/html" }
    })
      .then(response => response.text())
      .then(html => {
        if (this.hasTeamPanelTarget) {
          this.teamPanelTarget.innerHTML = html
        }
      })
      .catch(error => {
        console.error("Failed to load user mood:", error)
        if (this.hasTeamPanelTarget) {
          this.teamPanelTarget.innerHTML = "<p>Error loading mood history.</p>"
        }
      })
  }

  showTeamMood() {
    this.moodCardTargets[0].style.display = "none"
    this.moodCardTargets[1].style.display = "none"
    this.moodCardTargets[2].style.display = "flex"

    this.teamSectionTarget.style.display = "block"
    this.personalSectionTarget.style.display = "none"

    this.showTeamBtnTarget.style.display = "none"
    this.showOwnBtnTarget.style.display = "inline-block"

    const firstMember = this.element.querySelector(".member-card")
    if (firstMember) firstMember.click()
  }

  showOwnMood() {
    this.moodCardTargets.forEach(card => {
      card.style.display = "flex"
    })

    this.teamSectionTarget.style.display = "none"
    this.personalSectionTarget.style.display = "block"

    this.showTeamBtnTarget.style.display = "inline-block"
    this.showOwnBtnTarget.style.display = "none"
  }
}
