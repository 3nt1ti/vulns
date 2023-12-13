const express = require('express');
const app = express();

app.use(express.json());

// Simulación de un "banco" con cuentas y saldos (objeto en memoria)
const Bank = {
  accounts: {
    '1234567890': { balance: 1000 }, // Ejemplo: Cuenta 1234567890 con un saldo inicial de 1000
    '0987654321': { balance: 500 }, // Ejemplo: Cuenta 0987654321 con un saldo inicial de 500
  },
  transfer: function(fromAccount, toAccount, amount, callback) {
    if (!this.accounts[fromAccount] || !this.accounts[toAccount]) {
      callback('Cuenta no encontrada', { success: false });
      return;
    }

    if (this.accounts[fromAccount].balance < amount) {
      callback('Fondos insuficientes', { success: false });
      return;
    }

    this.accounts[fromAccount].balance -= amount;
    this.accounts[toAccount].balance += amount;

    callback(null, { success: true });
  },
};

// Ruta POST '/transfer' para manejar las transferencias
app.post('/transfer', (req, res) => {
  let fromAccount = req.body.fromAccount;
  let toAccount = req.body.toAccount;
  let amount = parseFloat(req.body.amount); // Convertir la cantidad a un número

  Bank.transfer(fromAccount, toAccount, amount, (err, result) => {
    if (err) {
      console.log(`Error durante la transferencia: ${err}`);
      res.status(500).send('Error interno del servidor');
      return;
    }

    if (!result.success) {
      console.log(`Intento de transferencia fallido: ${fromAccount} a ${toAccount} cantidad: ${amount}`);
      res.status(401).send('Transferencia fallida');
      return;
    }

    // Transferencia exitosa: Puedes realizar acciones adicionales aquí si es necesario
    console.log(`Transferencia exitosa de ${amount} desde ${fromAccount} a ${toAccount}`);
    res.status(200).send('Transferencia exitosa');
  });
});


// Simulación de usuarios (objeto en memoria)
const users = [
  { username: 'usuario1', password: 'password1' },
  { username: 'usuario2', password: 'password2' },
];

// Función para encontrar un usuario por nombre de usuario
const findUserByUsername = (username) => {
  return users.find(user => user.username === username) || null;
};

// Función para comparar contraseñas
const comparePasswords = (password, hashedPassword) => {
  return password === hashedPassword;
};

app.post('/login', (req, res) => {
  let username = req.body.username;
  let password = req.body.password;

  const user = findUserByUsername(username);

  if (!user || !comparePasswords(password, user.password)) {
    console.log(`Intento de inicio de sesión fallido: ${username} / ${password}`);
    res.status(401).send('Nombre de usuario o contraseña inválidos');
    return;
  }

  console.log(`Inicio de sesión exitoso para ${username} / ${password}`);
  res.status(200).send('Inicio de sesión exitoso');
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
