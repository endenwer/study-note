B = ReactBootstrap
@SearchField = React.createClass

  handleSubmit: (e) ->
    e.preventDefault()
    query = @refs.query.getValue()
    if query == ""
      @props.onSearch()
    else
      @props.onSearch(query)

  render: ->
    <form onSubmit={@handleSubmit}>
      <B.Input>
        <B.Row>
          <B.Col xs={11} >
            <B.Input defaultValue={@props.query} type="text" ref="query"/>
          </B.Col>
          <B.Col xs={1} >
            <B.ButtonInput type="submit"  value="Поиск"/>
          </B.Col>
        </B.Row>
      </B.Input>
    </form>
