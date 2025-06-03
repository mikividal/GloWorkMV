function updateMoodBar(value) {
  const moodBar = document.getElementById("mood-bar");

  if (value < 33) {
    moodBar.className = "mood-bar red";
  } else if (value > 66) {
    moodBar.className = "mood-bar green";
  } else {
    moodBar.className = "mood-bar yellow";
  }
}

// Example Usage
updateMoodBar(45); // Changes bar to yellow
