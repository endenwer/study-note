@TopPanel = React.createClass
  query: React.PropTypes.string.isRequire
  currentCategoryId: React.PropTypes.number.isRequire
  onSearch: React.PropTypes.func.isRequire
  onSelectCategory: React.PropTypes.func.isRequire

  render: ->
    <div className="top-panel">
      <div className="container">
        <div>
          <SearchField
            query={@props.query}
            onSearch={@props.onSearch} />
          <CategorySelector
            categories={@props.categories}
            current={@props.currentCategoryId}
            onSelect={@props.onSelectCategory} />
        </div>
        <NoteForm
          onCreate={@props.onCreate}
          categories={@props.categories}
          csrf_param={@props.csrf_param}
          csrf_token={@props.csrf_token} />
      </div>
    </div>
