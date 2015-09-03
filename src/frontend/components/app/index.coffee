require('./style.scss')

request = require('superagent')

module.exports =
  template: require('./template.html')

  components:
    hunks: require('../diff_hunk')

  data: ->
    versions: []
    diffHunks: []
    sourceVersion: ''
    targetVersion: ''
    msgNotice: ''
    msgError: ''

  created: ->
    request
      .get('/versions')
      .end (err, res) =>
        @versions = res.body
        @sourceVersion = @targetVersion = @versions[@versions.length - 2]

  methods:
    fetchDiff: ->
      @diffHunks = []
      @msgNotice = ''
      @msgError  = ''

      request
        .get("/diff/#{@sourceVersion}/#{@targetVersion}")
        .end (err, res) =>
          if res.ok
            @diffHunks = res.body
            @msgNotice = 'No changes found.' if @diffHunks.length == 0
          else
            @msgError = 'Sorry, some error has occurred.'
