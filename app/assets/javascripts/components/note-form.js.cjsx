@NoteForm = React.createClass
  onCreate: React.PropTypes.func.isRequire

  getInitialState: ->
    visibility: false

  componentDidMount: ->
    $(document).bind('click', this.handleOutsideClick)

  componentWillUnmount: ->
    $(document).bind('click', this.handleOutsideClick)

  componentDidUpdate: ->
    @refs.text.focus() if @state.visibility


  # Visibility to false when click outside the form
  handleOutsideClick: (e) ->
    if @refs.form
      form = ReactDOM.findDOMNode(@refs.form)
      unless (e.target == form  || $(form).has(e.target).length)
        @state.visibility = false
        @setState(@state)

  handleSubmit: (e) ->
    e.preventDefault()
    text = @refs.text.value
    return unless text

    @props.onCreate(text: text)
    @refs.text.value = ""
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
        <input type='text' ref='text'/>
        <input type='submit' value='Добавить' />
      </form>
      <button className={buttonClass} onClick={@handleButtonClick}>Добавить</button>
    </div>
