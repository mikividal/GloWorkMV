import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.setupMemberClick();
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
        const avatarUrl = member.dataset.avatarUrl;

        userDetails.innerHTML = `
          <div class="user-details-card">
            <img src="${avatarUrl}" alt="${fullName}'s avatar" class="avatar-large" />
            <h2>${fullName}</h2>
            <p><strong>Position:</strong> ${job}</p>
            <p><strong>Team:</strong> ${team}</p>
            <p><strong>📍Location:</strong> ${location}</p>
            <p><strong>Email:</strong> <a href="mailto:${email}">${email}</a></p>
          </div>
        `;

        userDetails.classList.remove("hidden");
      });
    });
  }
}
