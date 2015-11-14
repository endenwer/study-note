B = ReactBootstrap
@NoteForm = React.createClass
  onCreate: React.PropTypes.func.isRequire

  getInitialState: ->
    visibility: false

  initDropzone: ->
    Dropzone.autoDiscover = false
    @dropzone = new Dropzone(ReactDOM.findDOMNode(@refs.dropzone), {
      clickable: true
      addRemoveLinks: true
      dictDefaultMessage: "Для загрузки файлов<br>Перетащите их сюда или кликните"
    })
    @attachment_ids = []
    @dropzone.on "success", (file, response) =>
      @attachment_ids.push response.id

  componentDidMount: ->
    $(document).bind('click', this.handleOutsideClick)
    @initDropzone()

  componentWillUnmount: ->
    $(document).bind('click', this.handleOutsideClick)

  componentDidUpdate: ->
    @refs.noteInput.getInputDOMNode().focus() if @state.visibility

  # Visibility to false when click outside the form
  handleOutsideClick: (e) ->
    if @refs.form
      form = ReactDOM.findDOMNode(@refs.form)
      unless (e.target == form  || $(form).has(e.target).length)
        @state.visibility = false
        @setState(@state)

  handleSubmit: ->
    text = @refs.noteInput.getValue()
    category = @props.category
    return unless text

    note =
      text: text
      category_id: category
      attachment_ids: @attachment_ids
    @props.onCreate(note)
    @refs.noteInput.getInputDOMNode().value = ""
    @state.visibility = false
    @setState(@state)

  handleButtonClick: ->
    @state.visibility = true
    @setState(@state)

  # I have no idea why, but when click on dropzone
  # it triggered the outside click event
  handleDropzoneClick: ->
    @state.visibility = true
    @setState(@state)

  render: ->
    if @state.visibility
      formClass = "show"
      buttonClass = "hidden"
    else
      formClass = "hidden"
      buttonClass = "show"
    <div>
      <div className={formClass} ref='form'>
        <B.Input type='text' ref='noteInput' placeholder='Введите что-нибудь...' />
        <form action="/attachments" onClick={@handleDropzoneClick} ref='dropzone' className="dropzone dropzone-container">
          <input type="hidden" name={ @props.csrf_param } value={ @props.csrf_token } />
        </form>
        <B.Button onClick={@handleSubmit} bsStyle='success'>Добавить</B.Button>
      </div>
      <B.Button className={buttonClass} onClick={@handleButtonClick}>Добавить</B.Button>
    </div>
