@NoteList = (props) ->
  notes = props.notes.map (note) ->
    <Note
      key={note.id}
      id={note.id}
      text={note.text}
      onEdit={props.onNoteEdit}
      attachments={note.attachments}
      csrf_param={props.csrf_param}
      csrf_token={props.csrf_token}
    />
  <div>
    {notes}
  </div>

@NoteList.PropTypes =
  notes: React.PropTypes.array.isRequire
  csrf_param: React.PropTypes.string.isRequire
  csrf_token: React.PropTypes.string.isRequire

