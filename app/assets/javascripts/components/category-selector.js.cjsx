B = ReactBootstrap
@CategorySelector = React.createClass
  categories: React.PropTypes.array.isRequire

  handleChange: (e) ->
    value = e.target.value
    if value == ""
      @props.onSelect()
    else
      @props.onSelect(value)

  render: ->
    options = @props.categories.map (category) ->
      <option key={category.id} value={category.id}>{category.name}</option>
    <B.Input defaultValue={@props.current} type="select" onChange={@handleChange}>
      <option value="">Все записи</option>
      {options}
    </B.Input>
