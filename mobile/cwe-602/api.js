const express = require('express');
const app = express();

// Ruta para recibir la solicitud de transferencia
app.post('/realizarTransferencia', (req, res) => {
    // Validar la cantidad recibida del cliente
    const cantidadTransferencia = parseFloat(req.params.cantidad);


    // Condiciones validadas en el cliente
    /*
    if (isNaN(cantidadTransferencia) || cantidadTransferencia <= 0 || cantidadTransferencia > MAX_TRANSFER_AMOUNT) {
        return res.status(400).send("Cantidad de transferencia inválida.");
    }
    */

    // ... Código para procesar la transferencia

    return res.status(200).send("Transferencia realizada exitosamente.");
});

app.listen(3000, () => {
    console.log('Servidor en ejecución en el puerto 3000');
});
