document.addEventListener("DOMContentLoaded", function () {
  const showTeamBtn = document.getElementById("show-team-mood");
  const showOwnBtn = document.getElementById("show-own-mood");
  const teamSection = document.getElementById("team-mood-section");
  const personalSection = document.getElementById("personal-team-mood");

  const moodCards = document.getElementById("mood-cards").children;

  if (showTeamBtn && showOwnBtn) {
    showTeamBtn.addEventListener("click", () => {
      moodCards[0].style.display = "none";
      moodCards[1].style.display = "none";
      moodCards[2].style.display = "flex";
      teamSection.style.display = "block";
      personalSection.style.display = "none";

      showTeamBtn.style.display = "none";
      showOwnBtn.style.display = "inline-block";
    });

    showOwnBtn.addEventListener("click", () => {
      moodCards[0].style.display = "flex";
      moodCards[1].style.display = "flex";
      moodCards[2].style.display = "flex";
      teamSection.style.display = "none";
      personalSection.style.display = "block";

      showTeamBtn.style.display = "inline-block";
      showOwnBtn.style.display = "none";
    });
  }
});
