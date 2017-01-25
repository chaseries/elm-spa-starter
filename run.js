var express = require("express"),
    path = require("path"),
    boilerplate = path.join(__dirname, "build/index.html");

var config = {
  PORT: 9090
}

var app = express();
app.use('/static', express.static('build'));

var sendBoilerplate = function sendBoilerplate(req, res) {
  res.sendFile(boilerplate);
}

app.get('/', sendBoilerplate);
app.get('/dashboard', sendBoilerplate);
app.get('/404', sendBoilerplate);
app.get('/unauthorized', sendBoilerplate);

app.listen(config.PORT, function() {
  console.log("Application running on port " + config.PORT + ".")
});
