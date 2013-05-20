/*
*/








/*
// サーバー2
var system = require('system');

server = require('webserver').create();
service = server.listen(4568, function (request, response)
{
  response.statusCode = 200;
  response.write('<html><body>Hello, World!</body></html>');
  response.close();
});

if (!service)
{
  console.log('Error: Could not create web server listening on port ' + 4568);
  phantom.exit();
}
*/


/*
// サーバー
var system = require('system');

if (system.args.length !== 2)
{
  console.log('Usage: tmp.js <portnumber>');
  phantom.exit(1);
}
else
{
  port = system.args[1];
  server = require('webserver').create();
  
  service = server.listen(port, function (request, response)
  {
    response.statusCode = 200;
    response.write('<html><body>Hello, World!</body></html>');
    response.close();
  });
  
  if (!service)
  {
    console.log('Error: Could not create web server listening on port ' + port);
    phantom.exit();
  }
}
*/


/*
// ロードしたページにjqueryを使用できる
var page = require('webpage').create();
var url = 'http://www.google.co.jp/';
page.open(url, function(status)
{
  page.includeJs('http://code.jquery.com/jquery-1.9.1.min.js', function()
  {
    console.log(page.evaluate(function()
    {
      return $('title').text();
    }));
    phantom.exit();
  });
});
*/

/*
// スクリーンショットをとる
var page = require('webpage').create();
var url = 'http://www.google.co.jp/';
page.open(url, function(status)
{
  page.render('google.png');
  phantom.exit();
});
*/

