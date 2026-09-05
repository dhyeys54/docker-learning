const http = require('http');
const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.POSTGRES_HOST,
  port: process.env.POSTGRES_PORT || 5432,
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DB,
});

const server = http.createServer(async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end(`Hello from Node.js! DB time: ${result.rows[0].now}\n`);
  } catch (err) {
    res.writeHead(500, { 'Content-Type': 'text/plain' });
    res.end(`DB connection failed: ${err.message}\n`);
  }
});

server.listen(3000, () => console.log('Node webserver listening on port 3000'));
