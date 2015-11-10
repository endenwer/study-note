@NoteBox = React.createClass
  notes: React.PropTypes.array.isRequire

  getInitialState: ->
    notes: @props.notes

  onCreate: (note) ->
    $.post('/notes', note: note)
      .done (note) =>
        @state.notes.unshift(note)
        @setState(@state)

  render: ->
    <div>
      <NoteForm onCreate={@onCreate}/>
      <NoteList notes={@state.notes} />
    </div>
