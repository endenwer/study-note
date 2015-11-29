B = ReactBootstrap
@Note = React.createClass
  id: React.PropTypes.number.isRequire
  text: React.PropTypes.string.isRequire
  attachments: React.PropTypes.array

  getInitialState: ->
    editing: false
    attachments: @props.attachments

  mountDropzone: ->
    Dropzone.autoDiscover = false
    @dropzone = new Dropzone(ReactDOM.findDOMNode(@refs.dropzone), {
      clickable: true
      addRemoveLinks: true
      dictDefaultMessage: "Для загрузки файлов<br>Перетащите их сюда или кликните"
    })
    @attachments = @props.attachments ? []
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
    if @state.editing
      @mountDropzone()

  onSave: ->
    _.remove(@attachments, (attachment) =>
      _.include(@deletedAttachmentIds, attachment.id)
    )
    @props.onEdit(@props.id,
                  @refs.noteInput.getValue(),
                  @attachments,
                  @deletedAttachmentIds)
    @setState(editing: false)


  render: ->
    attachments = @props.attachments.map (attachment) ->
      <span key={attachment.id}>
        <a href={attachment.url}>{attachment.name}</a>
        <br/>
      </span>
    if @state.editing
      note =
        <div>
          <B.Input type="textarea" defaultValue={@props.text} ref='noteInput' />
          <form action="/attachments" ref='dropzone' className="dropzone dropzone-container">
            <input type="hidden" name={ @props.csrf_param } value={ @props.csrf_token } />
          </form>
          <B.Button onClick={@onSave}>Сохранить</B.Button>
          <B.Button onClick={() => @setState(editing: false)}>Отмена</B.Button>
        </div>
    else
      note =
        <div>
          <div>{@props.text}</div>
          {attachments}
          <B.Button onClick={() => @setState(editing: true)}>Редактировать</B.Button>
        </div>
    <div className='note'>
      {note}
    </div>
