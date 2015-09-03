fs = require('fs')
semver = require('semver')

module.exports = (req, res) ->
  fs.readdir req.app.get('datadir'), (err, files) ->
    if err
      res.status(500).send( error: err.errno )
      return

    versions = files.filter (file) ->
      fs.statSync(req.app.get('datadir') + '/' + file).isDirectory()

    versions.sort (a, b) ->
      # node-semver allowed valid semver string not "7.0.0RC1" but "7.0.0-rc1"
      aTag = a.replace(/^(.*)RC([0-9]+)$/, '$1-rc$2').replace(/^php-(.*)$/, '$1')
      bTag = b.replace(/^(.*)RC([0-9]+)$/, '$1-rc$2').replace(/^php-(.*)$/, '$1')
      semver.compare(aTag, bTag)

    res.send(versions)
