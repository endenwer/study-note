B = ReactBootstrap
@Note = React.createClass
  id: React.PropTypes.number.isRequire
  text: React.PropTypes.string.isRequire
  editing: React.PropTypes.bool.isRequire
  onSave: React.PropTypes.func.isRequire
  onEdit: React.PropTypes.func.isRequire
  onCancelEditing: React.PropTypes.func.isRequire
  attachments: React.PropTypes.array

  mountDropzone: ->
    Dropzone.autoDiscover = false
    @dropzone = new Dropzone(ReactDOM.findDOMNode(@refs.dropzone), {
      clickable: true
      addRemoveLinks: true
      dictDefaultMessage: "Для загрузки файлов<br>Перетащите их сюда или кликните"
    })
    @attachments = [].concat(@props.attachments)
    @deletedAttachmentIds = []
    @dropzone.on "success", (file, newAttachment) =>
      @attachments.push newAttachment
      file.id = newAttachment.id
    @dropzone.on "removedfile", (file) =>
      @deletedAttachmentIds.push(file.id)

    @attachments.forEach (attachment) =>
      @dropzone.emit("addedfile", attachment)
      @dropzone.emit("complete", attachment)

  componentDidUpdate: ->
    if @props.editing
      @mountDropzone()

  onSaveClick: ->
    _.remove(@attachments, (attachment) =>
      _.include(@deletedAttachmentIds, attachment.id)
    )
    @props.onSave(@props.id,
                  @refs.noteInput.getValue(),
                  @attachments,
                  @deletedAttachmentIds)

  render: ->
    attachments = @props.attachments.map (attachment) ->
      <span key={attachment.id}>
        <a href={attachment.url}>{attachment.name}</a>
        <br/>
      </span>
    if @props.editing
      note =
        <div>
          <B.Input type="textarea" defaultValue={@props.text} ref='noteInput' />
          <form action="/attachments" ref='dropzone' className="dropzone dropzone-container">
            <input type="hidden" name={ @props.csrf_param } value={ @props.csrf_token } />
          </form>
          <B.Button onClick={@onSaveClick}>Сохранить</B.Button>
          <B.Button onClick={@props.onCancelEditing}>Отмена</B.Button>
        </div>
    else
      note =
        <div>
          <div>{@props.text}</div>
          {attachments}
          <B.Button onClick={@props.onEdit}>Редактировать</B.Button>
        </div>
    <div className='note'>
      {note}
    </div>
