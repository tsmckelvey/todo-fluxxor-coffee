cs = require './constants'

module.exports =
  addTodo: (text) ->
    @dispatch cs.ADD_TODO, { text }

  toggleTodo: (todo) ->
    @dispatch cs.TOGGLE_TODO, { todo }

  clearTodos: ->
    @dispatch cs.CLEAR_TODOS
