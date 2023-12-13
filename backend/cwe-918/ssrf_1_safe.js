const express = require('express');
const axios = require('axios');
const app = express();

// Definir una lista blanca de URLs permitidas
const whitelist = [
    'ejemplo.com/archivo1',
    'ejemplo.com/archivo2',
    'www.somosmach.com',
];

app.get('/sendpay/:callback', async (req, res) => {
  let fileUrl = req.params.callback;

  // Verificar si la URL está en la lista blanca
  if (whitelist.includes(fileUrl)) {
    try {
      const response = await axios.get('http://' + fileUrl);
      res.send(response.data);
    } catch (error) {
      res.status(500).json({ error: 'Error fetching file' });
    }
  } else {
    res.status(403).json({ error: 'URL not allowed' });
  }
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
