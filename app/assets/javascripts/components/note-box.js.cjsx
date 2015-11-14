B = ReactBootstrap
@NoteBox = React.createClass
  notes: React.PropTypes.array.isRequire
  categories: React.PropTypes.array.isRequired
  currentCategoryId: React.PropTypes.number
  q: React.PropTypes.string

  getDefaultProps: ->
    currentCategoryId: null
    q: null

  getInitialState: ->
    currentCategoryId: @props.currentCategoryId
    notes: @props.notes
    q: @props.q

  componentWillUpdate: (nextProps, nextState) ->
    url = "/"
    if nextState.currentCategoryId
      url += "c/#{nextState.currentCategoryId}/"
    if nextState.q
      url += "?q=#{nextState.q}"
    window.history.pushState('', '', url)

  getNotes: ->
    query =
      category_id: @state.currentCategoryId
      q: @state.q
    $.get('/notes.json', query)
      .done (notes) =>
        @state.notes = notes
        @setState(@state)

  onCreate: (note) ->
    $.post('/notes', note: note)
      .done (note) =>
        @state.notes.unshift(note)
        @setState(@state)

  onSelectCategory: (categoryId = null) ->
    @state.currentCategoryId = categoryId
    @getNotes()


  onSearch: (q = null) ->
    @state.q = q
    @getNotes()

  render: ->
    <div>
      <SearchField query={@state.q} onSearch={@onSearch}/>
      <CategorySelector categories={@props.categories} current={@state.currentCategoryId} onSelect={@onSelectCategory}/>
      <NoteForm onCreate={@onCreate} category={@props.currentCategoryId} csrf_param={@props.csrf_param} csrf_token={@props.csrf_token}/>
      <NoteList notes={@state.notes} />
    </div>
