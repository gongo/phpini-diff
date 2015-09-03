require('./style.scss')

module.exports =
  props: ['hunks']
  template: require('./template.html')

  data: ->
    hunks: []
