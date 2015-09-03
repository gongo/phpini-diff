express = require('express')
app     = express()

app.set 'datadir', "#{__dirname}/../../data"

app.use '/',                     express.static("#{__dirname}/../../public")
app.get '/versions',             require('./versions')
app.get '/diff/:source/:target', require('./diff')

port   = process.env.PORT || 8080
server = app.listen port, ->
  console.log('Listening on port %d', server.address().port)
