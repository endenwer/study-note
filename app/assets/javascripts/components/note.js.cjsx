@Note = (props) ->
  <div>{props.text}</div>

@Note.PropTypes = { text: React.PropTypes.string.isRequire }
