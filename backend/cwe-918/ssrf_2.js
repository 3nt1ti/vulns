const express = require('express');
const request = require('request');

const app = express();

app.get('/vulnerable', (req, res) => {

  let url = `http://${req.headers.host}/`;
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
  console.log("API escuchando en puerto 3000");
})

