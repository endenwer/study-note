@TopPanel = React.createClass

  render: ->
    <div className="top-panel">
      <div className="container">
        <div>
          <SearchField
            query={ @props.query }
            onSearch={ @props.onSearch } />
          <CategorySelector
            categories={ @props.categories }
            current={ @props.currentCategoryId }
            onSelect={ @props.onSelectCategory } />
        </div>
        <NoteForm
          onCreate={ @props.onCreate }
          csrf_param={ @props.csrf_param }
          csrf_token={ @props.csrf_token } />
      </div>
    </div>
