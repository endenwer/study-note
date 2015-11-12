class NotesController < ApplicationController
  before_action :notes, only: [:index]

  def index
    categories = Category.all
    @presenter = {
      notes: notes,
      categories: categories
    }
    @presenter[:q] = params[:q] if params[:q]

    respond_to do |format|
      format.html
      format.json { render json: notes }
    end
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      render json: @note
    else
      render :nothing, status: 422
    end
  end

  private

  def note_params
    params.require(:note).permit(:text, :category_id)
  end
end
