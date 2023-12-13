const express = require('express');
const app = express();


app.delete('/api/accounts/:accountId', function(req, res){
    const accountId = parseInt(req.params.accountId);
    const account = db.fetchUser(accountId);

    db.deleteUser(account);
    return res.json({ message: 'Cuenta eliminada exitosamente' });
});

app.post('/api/:userId/delete', function(req, res) {
  var user = db.fetchUser(req.params.userId);
  db.deleteUser(user);
});



app.post('/api/:userId/delete', function(req, res) {
  var user = db.fetchUser(req.params.userId);
  if (req.session.user && req.session.user.id === user.id) {
    db.deleteUser(user);
  } else {
    res.status(403).send('No tienes permiso para eliminar este usuario');
  }
});


app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
