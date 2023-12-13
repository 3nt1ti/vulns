const express = require('express');
const app = express();
const ACL = require('acl2');

// Simulación de una base de datos de usuarios
const db = {
    users: [
        { id: 1, name: 'Usuario 1', role: 'admin' },
        { id: 2, name: 'Usuario 2', role: 'user' },
        { id: 3, name: 'Usuario 3', role: 'user' }
    ],
    fetchUser: function (accountId) {
        return this.users.find(user => user.id === accountId);
    },
    deleteUser: function (userToDelete) {
        const index = this.users.findIndex(user => user.id === userToDelete.id);
        if (index !== -1) {
            this.users.splice(index, 1);
        }
    }
};

// ACL para control de acceso
const acl = new ACL(new ACL.memoryBackend());

// Roles
acl.allow([
    {
        roles: ['admin'],
        allows: [
            { resources: '/api/accounts/:accountId', permissions: 'delete' }
        ]
    },
    {
        roles: ['user'],
        allows: [
            { resources: '/api/accounts/:accountId', permissions: 'delete' }
        ]
    }
]);

// Middleware para control de acceso
const checkPermission = function (req, res, next) {
    const accountId = parseInt(req.params.accountId);
    const userId = req.user.id; // Suponiendo que se establece un usuario en la solicitud

    const user = db.fetchUser(userId);
    if (!user) {
        return res.status(401).json({ message: 'Acceso no autorizado' });
    }

    const resource = `/api/accounts/${accountId}`;

    if (user.role === 'user' && accountId !== userId) {
        return res.status(403).json({ message: 'No tiene permiso para modificar esta cuenta' });
    }

    acl.isAllowed(user.role, resource, 'delete', function (err, allowed) {
        if (err || !allowed) {
            return res.status(403).json({ message: 'No tiene permiso para realizar esta acción' });
        }
        next();
    });
};

// Ruta para eliminar una cuenta de usuario
app.delete('/api/accounts/:accountId', checkPermission, function(req, res){
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
