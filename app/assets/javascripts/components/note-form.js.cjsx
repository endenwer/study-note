@NoteForm = React.createClass
  onCreate: React.PropTypes.func.isRequire

  handleSubmit: (e) ->
    e.preventDefault()
    text = @refs.text.value
    return unless text

    @props.onCreate(text: text)
    @refs.text.value = ""

  render: ->
    <form onSubmit={@handleSubmit} >
      <input type='text'  ref='text'/>
      <input type='submit' value='Добавить' />
    </form>
