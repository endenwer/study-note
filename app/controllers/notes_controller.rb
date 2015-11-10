class NotesController < ApplicationController

  def index
    @notes = Note.all
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      render json: @note
    else
      render status: 422
    end
  end

  private

  def note_params
    params.require(:note).permit(:text)
  end
end
