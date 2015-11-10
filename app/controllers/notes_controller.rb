class NotesController < ApplicationController

  def index
    @notes = Note.all
    @note = Note.new
  end

  def create
    @note = Note.create(note_params)
    redirect_to root_path
  end

  private

  def note_params
    params.require(:note).permit(:text)
  end
end
