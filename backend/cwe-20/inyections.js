const express = require('express');
const app = express();
const child_process = require('child_process');
// const req = require("express/lib/request");


app.get('/api/transactions/check', function(req, res) {
  let checkTerm = req.query.checkterm;
  console.log(checkTerm)
  child_process.exec('check ' + checkTerm, function(err, stdout, stderr) {
    res.send(stdout);
  });
});
// http://localhost:3000/api/transactions/check?checkterm=;cat /etc/passwd
// http://localhost:3000/api/transactions/check?checkterm=;uname%20-a


app.get('/api/accounts/search', function(req, res) {
  var html = "Not found account: " + req.query.search;
  res.send(html);
});
// http://localhost:3000/api/accounts/search?search=test<script>alert('xss')</script>
// http://localhost:3000/api/accounts/search?search=test%3Cscript%3Ealert(document.cookie)%3C/script%3E


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
