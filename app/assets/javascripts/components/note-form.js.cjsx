B = ReactBootstrap
@NoteForm = React.createClass
  onCreate: React.PropTypes.func.isRequire

  getInitialState: ->
    visibility: false

  componentDidMount: ->
    $(document).bind('click', this.handleOutsideClick)

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

  handleSubmit: (e) ->
    e.preventDefault()
    text = @refs.noteInput.getValue()
    category = @props.category
    return unless text

    @props.onCreate(text: text, category_id: category)
    @refs.noteInput.getInputDOMNode().value = ""
    @state.visibility = false
    @setState(@state)

  handleButtonClick: ->
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
      <form className={formClass} onSubmit={@handleSubmit} ref='form'>
        <B.Input type='text' ref='noteInput' placeholder='Введите что-нибудь...' />
        <B.ButtonInput type='submit' bsStyle='success' value='Добавить' />
      </form>
      <B.Button className={buttonClass} onClick={@handleButtonClick}>Добавить</B.Button>
    </div>
