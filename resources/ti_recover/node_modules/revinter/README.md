# Revinter
Library for doing reversal interpolation on a string based on a pattern to recover tokens

## Installation
`npm install revinter`


## Example

```javascript
const revinter = require('revinter');

let expression = "Send an e-mail to Peter telling him I'll be late for work.";
let pattern = "Send an ${type} to ${person} telling him ${message}";

console.log( revinter(expression, pattern) );
// {
//     type: "e-mail",
//     person: "Peter",
//     message: "I'll be late for work"
// }
```