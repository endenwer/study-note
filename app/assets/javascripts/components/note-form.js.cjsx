B = ReactBootstrap
@NoteForm = React.createClass
  onCreate: React.PropTypes.func.isRequire

  getInitialState: ->
    showModal: false

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
    @initDropzone()

  componentDidUpdate: ->
    @refs.noteInput.getInputDOMNode().focus() if @state.showModal

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
    @state.showModal = false
    @setState(@state)

  openModal: ->
    @state.showModal = true
    @setState(@state)

  closeModal: ->
    @state.showModal = false
    @setState(@state)

  render: ->
    if @state.showModal
      modalClass = "show"
      backdrop = <div className="modal-backdrop fade in"></div>
    else
      modalClass = "hidden"
      backdtop = ""
    <div>
      { backdrop }
      <div className="fade in modal #{modalClass}" tabIndex="-1" role="dialog" style={ { display:"block" } }>
        <div className="modal-dialog">
          <div className="modal-content" role="document">
            <div aria-label="Close" className="modal-header">
              <button type="button" onClick={@closeModal} className="close"><span aria-hidden="true">×</span></button>
              <h4 className="modal-title">Добавить запись</h4></div>
            <div className="modal-body">
              <div ref='form'>
                <B.Input type='text' ref='noteInput' placeholder='Введите что-нибудь...' />
                <form action="/attachments" ref='dropzone' className="dropzone dropzone-container">
                  <input type="hidden" name={ @props.csrf_param } value={ @props.csrf_token } />
                </form>
                <B.Button onClick={@handleSubmit} bsStyle='success'>Добавить</B.Button>
              </div>
            </div>
          </div>
        </div>
      </div>
      <B.Button onClick={@openModal}>Добавить</B.Button>
    </div>
