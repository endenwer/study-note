B = ReactBootstrap
@App = React.createClass
  notes: React.PropTypes.array.isRequire
  categories: React.PropTypes.array.isRequired
  totalPages: React.PropTypes.number.isRequired
  currentCategoryId: React.PropTypes.number
  q: React.PropTypes.string

  componentDidMount: ->
    if @state.totalPages > @state.page
      $(document).on('scroll', @onScroll)

  componentDidUpdate: ->
    if @state.totalPages > @state.page
      $(document).on('scroll', @onScroll)

  getDefaultProps: ->
    currentCategoryId: null
    q: null

  getInitialState: ->
    currentCategoryId: @props.currentCategoryId
    totalPages: @props.totalPages
    notes: @props.notes
    q: @props.q
    page: 1

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
      page: @state.page
    $.get('/notes.json', query)
      .done (data) =>
        if query.page == 1
          console.log(1)
          @state.notes = data.notes
        else
          console.log(2)
          data.notes.forEach (note)=>
            @state.notes.push(note)
        @state.totalPages = data.totalPages
        @setState(@state)

  onCreate: (note) ->
    $.post('/notes', note: note)
      .done (note) =>
        @state.notes.unshift(note)
        @state.offset += 1
        @setState(@state)

  onSelectCategory: (categoryId = null) ->
    @state.currentCategoryId = categoryId
    @state.page = 1
    @getNotes()


  onSearch: (q = null) ->
    @state.q = q
    @state.page = 1
    @getNotes()

  onScroll: (event) ->
    if ($(document).height() - window.pageYOffset - window.innerHeight < 250)
      @state.page += 1
      @getNotes()
      $(document).off('scroll', @onScroll)


  render: ->
    <div className='container'>
      <TopPanel
        onCreate={ @onCreate }
        onSearch={ @onSearch }
        onSelectCategory={ @onSelectCategory }
        query={ @state.q }
        categories={ @props.categories }
        currentCategoryId={ @state.currentCategoryId }
        csrf_param={ @props.csrf_param }
        csrf_token={ @props.csrf_token } />
      <NoteList notes={@state.notes} />
    </div>
