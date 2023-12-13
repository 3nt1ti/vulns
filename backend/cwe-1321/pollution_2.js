// Definición del objeto Cuenta
function Cuenta(id, user, balance) {
  this.id = id;
  this.user = user;
  this.balance = balance;
}

// Ejemplo de cuenta
const miCuenta = new Cuenta(1, 'ejemplo', 100);

// Mostrar la cuenta antes de la manipulación
console.log('Cuenta antes de la manipulación:', miCuenta);

// Función que simula la vulnerabilidad de la "prototype pollution"
function manipularPrototipo() {
  Cuenta.prototype.nuevoMetodo = function () {
    console.log('¡Prototype Pollution!');
  };
}

/*
function manipularPrototipo() {
  Object.assign(Cuenta.prototype, { nuevoMetodo: function () {
    console.log('¡Prototype Pollution!');
  }});
}
 */

// Ejecutar la función que manipula el prototipo
manipularPrototipo();

// Mostrar la cuenta después de la manipulación
console.log('Cuenta después de la manipulación:', miCuenta);

// Ejecutar el nuevo método añadido al prototipo
miCuenta.nuevoMetodo();
