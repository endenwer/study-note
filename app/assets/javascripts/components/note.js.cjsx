B = ReactBootstrap
@Note = (props) ->
  <B.Well>{props.text}</B.Well>

@Note.PropTypes = { text: React.PropTypes.string.isRequire }
