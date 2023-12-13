const a = { a: 1, b: 2 };


const data = JSON.parse('{"__proto__": { "polluted": true}}');
const c = Object.assign(Object.create(null), a, data);
console.log(c.polluted); // true
console.log(c.a);

const data2 = JSON.parse('{"__proto__": null}');
const d = Object.assign(Object.create(null), a, data2);
console.log(d.b);
d.hasOwnProperty('b');
