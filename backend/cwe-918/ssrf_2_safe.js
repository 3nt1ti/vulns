const express = require('express');
const request = require('request');

const ALLOWED_DOMAINS = ['somosmach.com'];

const app = express();

app.get('/vulnerable', (req, res) => {

  let host = new URL(`http://${req.headers.host}`).hostname;
  console.log(host)

  if (!ALLOWED_DOMAINS.includes(host)) {
    return res.status(400).send('Dominio no permitido');
  }
  let url = `http://${host}/`;
  console.log(url)

  request(url, (error, response, body) => {

    if (!error && response.statusCode == 200) {
      res.send(body);
    } else {
      res.status(500).send();
    }

  });

});


app.listen(3000, () => {
  console.log("API Safe escuchando en puerto 3000");
})
