@NoteList = (props) ->
  notes = props.notes.map (note) ->
    <Note key={note.id} text={note.text}/>
  <div>
    {notes}
  </div>

@NoteList.PropTypes = { notes: React.PropTypes.array.isRequire }
