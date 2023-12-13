const express = require('express');
const app = express();
const { execFile } = require('child_process');
const validator = require('validator');
const { query, validationResult } = require('express-validator');

app.get('/api/transactions/check', function(req, res) {
  let checkTerm = req.query.checkterm;

  // Validar el formato del término ingresado
  if (!validator.isAlphanumeric(checkTerm)) {
    return res.status(400).send('Error: El término no es válido.');
  }

  // Crear una estructura de datos inmutable (si es posible)
  const termToCheck = Object.freeze({ term: checkTerm });

  // Ejecutar el comando de manera segura usando execFile
  execFile('/ruta/a/tu/comando/check', [termToCheck.term], (err, stdout, stderr) => {
    if (err) {
      return res.status(500).send('Error interno en el servidor.');
    }
    res.send(stdout);
  });
});

// http://localhost:3000/api/transactions/check?checkterm=;cat /etc/passwd
// http://localhost:3000/api/transactions/check?checkterm=;uname%20-a



// Definir las reglas de validación para el parámetro 'search'
app.get('/api/accounts/search',
  query('search').escape().trim(), // Sanitizar el parámetro 'search'
  function(req, res) {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    var html = "Not found account: " + req.query.search;
    res.send(html);
  }
);
// http://localhost:3000/api/accounts/search?search=test<script>alert('xss')</script>


app.post('/api/bank/transactions', function(req, res) {
  let sql = 'INSERT INTO transactions (description) VALUES ("' + req.body.description + '")';
  db.query(sql, function(err, result) {
    if(err) throw err;
    console.log(result);
    res.send('Transaction updated...');
  });
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
