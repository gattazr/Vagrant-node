var http = require('http');

var server = http.createServer(function(req, res) {
	res.writeHead(200);
	res.end('Hello World !');
});
console.log('Server created');
server.listen(8080);
