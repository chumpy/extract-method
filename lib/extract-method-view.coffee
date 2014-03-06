{EditorView, View} = require 'atom'
Clipboard = require 'clipboard'

module.exports =
class ExtractMethodView extends View
  @content: ->
    @div class: "extract-method overlay from-top padded", =>
      @div class: "inset-panel", =>
        @div class: "panel-heading", =>
          @span "Extract selected text to method"
        @div class: "panel-body padded", =>
          @div outlet: 'signupForm', =>
            @subview 'methodNameEditor', new EditorView(mini:true, placeholderText: 'Enter a method name')
            @div class: 'pull-right', =>
              @button outlet: 'extractButton', class: 'btn btn-primary', "Extract method to clipboard"

  initialize: (serializeState) ->
    @handleEvents()
    atom.workspaceView.command "extract-method:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  handleEvents: ->
    @extractButton.on 'click', => @extractMethod()
    @methodNameEditor.on 'core:confirm', => @extractMethod()
    @methodNameEditor.on 'core:cancel', => @detach()

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)

  extractMethod: ->
    activeEditor = atom.workspace.getActiveEditor()
    @methodBody = activeEditor.getSelectedText()
    activeEditor.insertText(@methodNameEditor.getText())
    Clipboard.writeText(@buildRubyMethod(@methodBody))
    @destroy()

  buildRubyMethod: (methodBody)->
    "def #{@methodNameEditor.getText()}\n    #{methodBody}\n  end"
