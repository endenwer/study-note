@NoteList = (props) ->
  notes = props.notes.map (note) ->
    <Note
      key={note.id}
      {...note}
      onEdit={() => props.onNoteEdit(note.id)}
      onCancelEditing={() => props.onNoteEdit(null)}
      onSave={props.onNoteSave}
      editing={props.editingNoteId == note.id}
      csrf_param={props.csrf_param}
      csrf_token={props.csrf_token}
    />
  <div>
    {notes}
  </div>

@NoteList.PropTypes =
  notes: React.PropTypes.array.isRequire
  onNoteEdit: React.PropTypes.func.isRequire
  onNoteSave: React.PropTypes.func.isRequire
  csrf_param: React.PropTypes.string.isRequire
  csrf_token: React.PropTypes.string.isRequire
  editingNoteId: React.PropTypes.number

