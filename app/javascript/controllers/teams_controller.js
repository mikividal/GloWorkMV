import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.setupMemberClick();
  }

  toggleForm() {
    const form = this.element.querySelector("#new-member-form");
    form.classList.toggle("hidden");
  }

  setupMemberClick() {
    const members = this.element.querySelectorAll(".team-member");
    const userDetails = this.element.querySelector("#user-details");

    members.forEach((member) => {
      member.addEventListener("click", () => {
        const fullName = member.dataset.fullName;
        const job = member.dataset.jobPosition;
        const team = member.dataset.team;
        const location = member.dataset.location;
        const email = member.dataset.email;

        userDetails.innerHTML = `
          <h2>${fullName}</h2>
          <p>${job}</p>
          <p>${team}</p>
          <p>📍${location}</p>
          <p>Email: ${email}</p>
        `;

        userDetails.classList.remove("hidden");
      });
    });
  }
}
