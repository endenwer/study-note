@Notes = React.createClass
  render: ->
    notes = @props.notes.map (note) ->
      <div key={note.id}>{note.text}</div>
    <div>
      {notes}
    </div>

