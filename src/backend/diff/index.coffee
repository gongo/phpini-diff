fs     = require('fs')
path   = require('path')
zlib   = require('zlib')
stream = require('highland')
Diff   = require('./diff')

module.exports = (req, res) ->
  archivePaths = [
    "#{req.app.get('datadir')}/#{path.basename(req.params.source)}/php.ini.gz",
    "#{req.app.get('datadir')}/#{path.basename(req.params.target)}/php.ini.gz"
  ]

  error = null

  stream(archivePaths)
    .flatMap(stream.wrapCallback(fs.readFile))
    .flatMap(stream.wrapCallback(zlib.gunzip))
    .invoke('toString', ['utf-8'])
    .stopOnError (err) ->
      error = { code: err.errno }
    .apply (source, target) ->
      if error
        res.status(500).send(error)
      else
        diff = new Diff(source, target);
        res.send(diff.getLines())
