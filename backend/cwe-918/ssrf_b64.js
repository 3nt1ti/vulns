const express = require('express');
const axios = require('axios');
const app = express();

app.get('/download', async (req, res) => {
  let encodedUrl  = req.query.dest;

  console.log(encodedUrl)
  // Decoding the Base64-encoded URL
  const decodedUrl = Buffer.from(encodedUrl, 'base64').toString('utf-8');
  console.log(decodedUrl)

  // Making a request using the decoded URL
  try {
    const response = await axios.get(decodedUrl);
    // Sending the fetched file as a response or processing it further in a real application
    res.send(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Error fetching file' });
  }
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});

// http://localhost:3000/download?dest=aHR0cDovL3d3dy5nb29nbGUuY29t
