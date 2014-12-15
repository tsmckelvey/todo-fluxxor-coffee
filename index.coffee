express = require 'express'

app = express()

app.engine 'jade', require('jade').__express

app.set 'view engine', 'jade'

app.use express.static 'www'

app.get '/', (req, res) ->
  res.render 'index'

server = app.listen 3000, ->
  host = server.address().address
  port = server.address().port
