ExtractMethodView = require './extract-method-view'

module.exports =
  extractMethodView: null

  activate: (state) ->
    @extractMethodView = new ExtractMethodView(state.extractMethodViewState)

  deactivate: ->
    @extractMethodView.destroy()

  serialize: ->
    extractMethodViewState: @extractMethodView.serialize()
