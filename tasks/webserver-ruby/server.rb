require 'sinatra'
require 'pg'
require 'socket'

set :bind, '0.0.0.0'
set :port, 4567
set :host_authorization, permitted_hosts: []

def db_connect
  PG.connect(
    host: ENV['POSTGRES_HOST'],
    port: ENV['POSTGRES_PORT'] || 5432,
    user: ENV['POSTGRES_USER'],
    password: ENV['POSTGRES_PASSWORD'],
    dbname: ENV['POSTGRES_DB']
  )
end

get '/' do
  conn = db_connect
  conn.exec(<<~SQL)
    CREATE TABLE IF NOT EXISTS requests (
      id SERIAL PRIMARY KEY,
      server VARCHAR(255) NOT NULL,
      ip_address VARCHAR(45) NOT NULL,
      path VARCHAR(2048) NOT NULL,
      created_at TIMESTAMP NOT NULL DEFAULT NOW()
    )
  SQL

  conn.exec_params(
    'INSERT INTO requests (server, ip_address, path) VALUES ($1, $2, $3)',
    [Socket.gethostname, request.ip, request.path]
  )

  result = conn.exec('SELECT server, ip_address, path, created_at FROM requests ORDER BY id DESC')
  rows = result.map do |r|
    "<tr><td>#{r['created_at']}</td><td>#{r['server']}</td><td>#{r['ip_address']}</td><td>#{r['path']}</td></tr>"
  end.join

  <<~HTML
    <h1>Hello from Ruby! Served by #{Socket.gethostname}</h1>
    <h2>Recent requests</h2>
    <table border="1" cellpadding="6" cellspacing="0">
      <tr><th>Created At</th><th>Server</th><th>IP Address</th><th>Path</th></tr>
      #{rows}
    </table>
  HTML
rescue PG::Error => e
  status 500
  "DB connection failed: #{e.message}\n"
ensure
  conn&.close
end
