Fluxxor = require 'fluxxor'
cs = require '../constants'

module.exports = Fluxxor.createStore
  initialize: ->
    @todos = []

    # Action mappings can be passed into the createStore spec object
    # via the "actions" property, but this doesn't easily allow for referencing
    # constants (which your action names should be).
    # Ref: http://fluxxor.com/documentation/stores.html#-fluxxor-createstore-spec-
    actions = {}

    actions[cs.ADD_TODO] = @onAddTodo
    actions[cs.TOGGLE_TODO] = @onToggleTodo
    actions[cs.CLEAR_TODOS] = @onClearTodos

    @bindActions actions

  onAddTodo: (payload) ->
    @todos.push { text: payload.text, complete: false }
    @emit 'change'

  onToggleTodo: (payload) ->
    # This is a reference.  Altering payload.todo.complete is accessing the same
    # object as the one in our @todos array.
    # Ref: http://snook.ca/archives/javascript/javascript_pass
    payload.todo.complete = !payload.todo.complete

    @emit 'change'

  onClearTodos: ->
    @todos = @todos.filter (todo) -> !todo.complete
    @emit 'change'

  getState: -> { @todos }