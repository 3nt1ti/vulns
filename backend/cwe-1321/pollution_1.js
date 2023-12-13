const a = { a: 1, b: 2 };


const data = JSON.parse('{"__proto__": { "polluted": true}}');
const c = Object.assign({}, a, data);
console.log(c.polluted); // true
console.log(c.hasOwnProperty('a'));

const data2 = JSON.parse('{"__proto__": null}');
const d = Object.assign(a, data2);
d.hasOwnProperty('b'); // Uncaught TypeError: d.hasOwnProperty is not a function
