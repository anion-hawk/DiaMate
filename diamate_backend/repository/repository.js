require('dotenv').config();
const pg = require('pg');

const config = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    port: process.env.DB_PORT,
    ssl: true
};

const client = new pg.Client(config);
client.connect(err => {
    if (err) {
        console.error('connection error', err.stack);
    } else {
        console.log('connected to database');
    }
});

async function query(query, params) {
    try {
        const data = await client.query(query, params);
        return { success: true, data: data.rows };
    } catch (error) {
        return { success: false, error };
    }
}

module.exports = { query };