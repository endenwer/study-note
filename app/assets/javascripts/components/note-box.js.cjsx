B = ReactBootstrap
@NoteBox = React.createClass
  notes: React.PropTypes.array.isRequire

  getInitialState: ->
    notes: @props.notes

  onCreate: (note) ->
    $.post('/notes', note: note)
      .done (note) =>
        @state.notes.unshift(note)
        @setState(@state)

  onSelectCategory: (categoryId) ->
    if categoryId == ""
      window.location.href = "/"
    else
      window.location.href = "/c/#{categoryId}"

  render: ->
    categoryId = @props.currentCategory.id if @props.currentCategory
    <div>
      <CategorySelector categories={@props.categories} current={categoryId} onSelect={@onSelectCategory}/>
      <NoteForm onCreate={@onCreate} category={@props.currentCategory}/>
      <NoteList notes={@state.notes} />
    </div>
