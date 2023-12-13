const express = require('express');
const app = express();
const bodyParser = require('body-parser');

// Simulación de base de datos
let accounts = [
  { id: 1, userId: 'user123', balance: 5000 },
  { id: 2, userId: 'user456', balance: 8000 }
];

// Middleware para parsear el body de las peticiones
app.use(bodyParser.json());

// Endpoint para eliminar una cuenta bancaria
app.delete('/api/accounts/:accountId', function(req, res) {
  const accountId = parseInt(req.params.accountId);
  const requestingUserId = req.headers['user-id']; // ID del usuario autenticado

  // Encontrar la cuenta en la base de datos
  const accountIndex = accounts.findIndex(acc => acc.id === accountId);

  if (accountIndex === -1) {
    return res.status(404).json({ error: 'Cuenta no encontrada' });
  }

  const account = accounts[accountIndex];

  // Verificar si el usuario tiene permiso para eliminar esta cuenta
  if (account.userId !== requestingUserId) {
    return res.status(403).json({ error: 'No tienes permiso para eliminar esta cuenta' });
  }

  // Eliminar la cuenta
  accounts.splice(accountIndex, 1);

  return res.json({ message: 'Cuenta eliminada exitosamente' });
});

// Iniciar el servidor en el puerto 3000
app.listen(3000, () => {
  console.log('Servidor iniciado en el puerto 3000');
});
