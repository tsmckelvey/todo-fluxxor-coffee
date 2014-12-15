Fluxxor = require 'fluxxor'
stores = require './stores'
actions = require './actions'

flux = new Fluxxor.Flux stores, actions

flux.on 'dispatch', (type, payload) -> console.log "[Dispatch]", type, payload if console?.log?

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

Application = React.createClass
  mixins: [FluxMixin, StoreWatchMixin('TodoStore')]

  getInitialState: -> { newTodoText: '' }

  getStateFromFlux: ->
    flux = @getFlux()

    flux.store('TodoStore').getState()

  handleTodoTextChange: (e) ->
    @setState { newTodoText: e.target.value }

  onSubmitForm: (e) ->
    e.preventDefault()
    if @state.newTodoText.trim()
      @getFlux().actions.addTodo @state.newTodoText
      @setState { newTodoText: '' }

  clearCompletedTodos: (e) ->
    @getFlux().actions.clearTodos()

  render: ->
    <div>
      <ul>
        {@state.todos.map (todo, i) ->
          <li key={i}><TodoItem todo={todo} /></li>
        }
      </ul>
      <form onSubmit={@onSubmitForm}>
        <input type="text" size="30" placeholder="New Todo" value={@state.newTodoText} onChange={@handleTodoTextChange} />
        <input type="submit" value="Add Todo" />
      </form>
      <button onClick={@clearCompletedTodos}>Clear Completed</button>
    </div>

TodoItem = React.createClass
  mixins: [FluxMixin]
  propTypes:
    todo: React.PropTypes.object.isRequired
  render: ->
    style =
      textDecoration: if @props.todo.complete then 'line-through' else ''

    <span style={style} onClick={@onClick}>{@props.todo.text}</span>

  onClick: ->
    @getFlux().actions.toggleTodo @props.todo

document.addEventListener 'DOMContentLoaded', (e) ->
  React.render <Application flux={flux} />, document.getElementById 'react_mountPoint'
