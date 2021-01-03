const http = require('http');
const port = process.env.PORT || 3000;

const app_host = process.env.APP_HOST || "unknown";
const app_version = process.env.APP_VERSION || "unknown";


const server = http.createServer((req, res) => {
  res.statusCode = 200;

const msg = `Hello World! Application version ${app_version} - Hostname ${app_host}\n`
  res.end(msg);
});

server.listen(port, () => {
  console.log(`Server running on http://localhost:${port}/`);
});
