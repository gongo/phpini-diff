jsdiff = require('diff')

DiffHunk = require('./diff_hunk')

class Diff
  constructor: (source, target) ->
    change = jsdiff.structuredPatch(null, null, source, target)
    @hunks = change.hunks

  getLines: ->
    @hunks.map (h) ->
      hunk = new DiffHunk(h)
      hunk.getLines()

module.exports = Diff
