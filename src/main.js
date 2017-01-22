require('./scss/main.scss')

var elm = require('./elm/Main.elm');
var mount = document.getElementById("app");
var app = elm.Main.embed(mount);
