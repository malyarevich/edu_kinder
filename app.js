var express = require('express');
var path = require('path');
var app = express();

const port = 2101;
require('./routes')(app, {});

/** Sever configs */
app.set('views', path.join(__dirname, 'docs/views'));
app.set('view engine', 'jade');
app.use(express.static(path.join(__dirname, 'docs')));

/** Sever content */
var sql = require("seriate");


// Change the config settings to match your
// SQL Server and database
var config = {
    "server": "127.0.0.1",
    "user": "kinder",
    "password": "123",
    "database": "Kinder_garden"
};

app.use(function(req, res, next) {
    /*sql.setDefaultConfig(config);
    console.log(req);
    sql.execute({
        query: "SELECT * FROM CHILD"
    }).then(function (results) {
        res.writeHead(200, { 'Content-Type' : 'application/json' });
        res.send(results);
        res.end();
        sql.end();
        console.log(results);
    }, function (err) {
        console.log("Execute error: ", err);
    });*/
    next();
});

app.get('/login', function(req, res) {
    res.sendFile(path.join(__dirname+'/docs/login.html'));
});

app.get('/index', function(req, res) {
    res.sendFile(path.join(__dirname+'/docs/index.html#home'));
});

app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname+'/docs/index.html#home'));
});

/** Error sector */
// catch 404 and forward to error handler
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

// error handler
app.use(function(err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error');
});

/** Listener */
app.listen(port, function () {
    console.log('Example app listening on port 2101!');
});