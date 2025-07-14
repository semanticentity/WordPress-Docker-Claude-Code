document.addEventListener('DOMContentLoaded', () => {
  const instancesDiv = document.getElementById('instances');

  fetch('/api/instances')
    .then(response => response.json())
    .then(instances => {
      instances.forEach(instance => {
        const instanceDiv = document.createElement('div');
        instanceDiv.classList.add('instance');
        instanceDiv.innerHTML = `
          <h3>${instance.name}</h3>
          <p>Status: ${instance.status}</p>
        `;
        instancesDiv.appendChild(instanceDiv);
      });
    });
});
