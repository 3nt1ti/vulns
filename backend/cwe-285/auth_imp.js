const express = require('express');
const app = express();

// Simulación de una base de datos de usuarios
const db = {
    users: [
        { id: 1, name: 'Usuario 1' },
        { id: 2, name: 'Usuario 2' },
        { id: 3, name: 'Usuario 3' }
    ],
    fetchUser: function (accountId) {
        // Simulación de la función para obtener un usuario por ID
        return this.users.find(user => user.id === accountId);
    },
    deleteUser: function (userToDelete) {
        // Simulación de la función para eliminar un usuario de la base de datos
        const index = this.users.findIndex(user => user.id === userToDelete.id);
        if (index !== -1) {
            this.users.splice(index, 1);
        }
    }
};

// Ruta para eliminar una cuenta de usuario
app.delete('/api/accounts/:accountId', function(req, res){
    const accountId = parseInt(req.params.accountId);
    const account = db.fetchUser(accountId);

    if (!account) {
        return res.status(404).json({ message: 'La cuenta no existe' });
    }

    db.deleteUser(account);
    return res.json({ message: 'Cuenta eliminada exitosamente' });
});

// Puerto en el que escucha el servidor
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en el puerto ${PORT}`);
});
