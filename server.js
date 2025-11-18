const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send('Hello from Advanced CI/CD! Version: 1.0.0');
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});

