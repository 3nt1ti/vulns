const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const BankAccount = require('./bankAccount_inmutable');

const app = express();

// Conexión a la base de datos (suponiendo que ya tienes la URL de conexión)
mongoose.connect('mongodb://localhost:27017/bank-db', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});
/*
const newAccount = new BankAccount({
  accountNumber: '1234567890',
  accountHolderName: 'John Doe',
  balance: 5000,
  role: user,
  isActive: true
});
 */

app.use(bodyParser.json());

app.put('/api/bank/tc/:id', function(req, res) {
  const accountId = req.params.id;
  const updateData = req.body;

  // Verificar si 'role' o 'balance' están presentes en updateData
  if ('role' in updateData || 'balance' in updateData) {
    res.status(400).send('Acción no permitida se notifica esta acción a área de riesgo.');
    return;
  }

  BankAccount.findById(accountId, function(err, account) {
    if (err) {
      res.status(500).send('Error interno al buscar la cuenta bancaria.');
      return;
    }

    if (!account) {
      res.status(404).send('La cuenta bancaria no fue encontrada.');
      return;
    }

    // Actualizar solo los campos permitidos (excepto 'role' y 'balance')
    Object.keys(updateData).forEach(key => {
      if (key !== 'role' && key !== 'balance') {
        account[key] = updateData[key];
      }
    });

    account.save(function(err, updatedAccount) {
      if (err) {
        res.status(500).send('Error al actualizar la cuenta bancaria.');
        return;
      }
      res.send('¡Cuenta bancaria actualizada!');
    });
  });
});

app.listen(3000, function() {
  console.log('Servidor escuchando en el puerto 3000');
});


