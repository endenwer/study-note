class NotesController < ApplicationController

  def index
    if params[:category_id]
      notes = Note.where(category_id: params[:category_id])
    else
      notes = Note.all
    end
    categories = Category.all
    @presenter = {
      notes: notes,
      categories: categories
    }
    respond_to do |format|
      format.html
      format.json { render json: { notes: notes } }
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
