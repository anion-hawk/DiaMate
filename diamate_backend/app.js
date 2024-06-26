const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const app = express();
const verifyToken = require('./util/verify_token');

app.use(cors());
app.options('*', cors());
app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


// Routes

app.get('/', (req, res) => {
    res.redirect(301, '/status');
});

app.get('/status', (req, res) => {
    res.status(200).json({ status: 'OK' });
});

app.use('/auth', require('./routes/auth'));
app.use(async function (req, res, next) {
    const verified = await verifyToken(req, res, next);
    if (verified) {
        next();
    }
    else {
        console.log('unverified');
        return;
    }
});

app.use('/forum', require('./routes/forum'));
app.use('/user', require('./routes/user'));
app.use('/planner', require('./routes/planner'));



app.use(function (err, req, res, next) {
    console.log(err);
    console.log(req.body)
    res.status(err.status || 500).json({ error: err.message });
});


module.exports = app;