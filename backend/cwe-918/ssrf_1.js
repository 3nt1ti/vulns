const express = require('express');
const axios = require('axios');
const app = express();

app.get('/sendpay/:callback', async (req, res) => {
  let fileUrl  = req.params['callback'];
  console.log(fileUrl)

  try {
    const response = await axios.get('http://' + fileUrl);
    res.send(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Error fetching file' });
  }
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});

// http://localhost:3000/sendpay/www.google.com
// http://localhost:3000/sendpay/www.somosmach.com
