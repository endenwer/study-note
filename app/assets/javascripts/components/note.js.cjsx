B = ReactBootstrap
@Note = (props) ->
  attachments = props.attachments.map (attachment) ->
    <span key={attachment.id}>
      <a href={attachment.url}>{attachment.name}</a>
      <br/>
    </span>
  <div className='note'>
    <p>{props.text}</p>
    {attachments}
  </div>

@Note.PropTypes = { text: React.PropTypes.string.isRequire }
@Note.PropTypes = { attachments: React.PropTypes.array }
