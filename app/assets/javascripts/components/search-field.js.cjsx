@SearchField = React.createClass

  handleSubmit: (e) ->
    e.preventDefault()
    query = @refs.query.value
    if query == ""
      @props.onSearch()
    else
      @props.onSearch(query)

  render: ->
    <form onSubmit={ @handleSubmit } className="search">
      <input  ref="query" defaultValue={ @props.query } type="text" placeholder='Поиск' />
      <a><span className="glyphicon glyphicon-search"></span></a>
    </form>
