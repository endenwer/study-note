B = ReactBootstrap
@CategorySelector = (props) ->
  options = props.categories.map (category) ->
    <option key={category.id} value={category.id}>{category.name}</option>
  <B.Input value={props.current} type="select" onChange={(e) => props.onSelect(e.target.value)}>
    <option value="">Все записи</option>
    {options}
  </B.Input>

@CategorySelector.PropTypes = { categories: React.PropTypes.array.isRequire }

