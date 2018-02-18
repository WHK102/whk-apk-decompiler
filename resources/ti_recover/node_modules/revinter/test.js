const revinter = require('./index');
const expect = require('expect');

describe('revinter function', () => {

    it("should get the value when the string ends with the token", done => {
        const pattern = "hello ${bar}";
        const expression = "hello world";
        const result = revinter(expression, pattern);
        expect(result.bar).toBe('world');
        done();
    });

    it("should get the value when the string starts with the token", done => {
        const pattern = "${foo} world!";
        const expression = "hello world!";
        const result = revinter(expression, pattern);
        expect(result.foo).toBe('hello');
        done();
    });

    it("should get multiple values within the string", done => {
        const expression = "Send an e-mail to Peter telling him I'll be late for work.";
        const pattern = "Send an ${type} to ${person} telling him ${message}";
        const result = revinter(expression, pattern);
        expect(result.type).toBe('e-mail');
        expect(result.person).toBe('Peter');
        expect(result.message).toBe(`I'll be late for work.`);
        done();
    });

});