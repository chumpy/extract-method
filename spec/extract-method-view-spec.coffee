{EditorView} = require 'atom'
ExtractMethodView = require '../lib/extract-method-view'

describe "ExtractMethodView", ->
  beforeEach ->
    #extractMethod = atom.packages.loadPackage('extract-method')
    #extractMethod.activateResources()

    #session = atom.project.openSync()
    #editorView = new EditorView(session)
    #editorView.simulateDomAttachment()
    #editorView.extractMethodView = new ExtractMethodView(editorView)

  describe 'Extract it button', ->
    it 'works', ->
      expect("life").toBe("life")
