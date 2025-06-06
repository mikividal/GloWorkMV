document.querySelectorAll('.simple-calendar td').forEach(td => {
  td.addEventListener('dblclick', (event) => {
    const clickedDate = td.getAttribute('data-date');
    const today = new Date().toISOString().split('T')[0];

    if (clickedDate < today) {
      console.log('Cannot create events in the past');
      return;
    }

    // Open the modal
    const createModal = new bootstrap.Modal(document.getElementById('exampleModal'));
    createModal.show();
  });
});
