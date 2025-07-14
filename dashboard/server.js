const express = require('express');
const app = express();
const port = 3000;

app.use(express.static('public'));

app.get('/api/instances', (req, res) => {
  const instances = [
    { name: 'WordPress Instance 1', status: 'Running' },
    { name: 'WordPress Instance 2', status: 'Stopped' },
    { name: 'WooCommerce Site', status: 'Running' },
  ];
  res.json(instances);
});

app.listen(port, () => {
  console.log(`Dashboard listening at http://localhost:${port}`);
});
