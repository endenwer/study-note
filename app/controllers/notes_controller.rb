class NotesController < ApplicationController
  before_action :notes, only: [:index]
  before_action :require_group

  def index
    categories = Category.all
    total_pages = (notes.total_count / NOTE_PER_PAGE.to_f).ceil
    @presenter = {
      notes: ActiveModel::SerializableResource.new(notes).serializable_hash,
      categories: categories,
      totalPages: total_pages,
      csrf_param: request_forgery_protection_token,
      csrf_token: form_authenticity_token
    }
    @presenter[:q] = params[:q] if params[:q]

    respond_to do |format|
      format.html
      format.json { render json: { notes: ActiveModel::SerializableResource.new(notes).serializable_hash,
                                   totalPages: total_pages } }
    end
  end

  def create
    if note_params[:attachment_ids].present?
      @note = Note.create_with_attachments(current_user, note_params)
    else
      @note = current_user.group.notes.create(note_params)
    end
    if @note.persisted?
      render json: @note
    else
      render nothing: true, status: 422
    end
  end

  private

  def note_params
    params.require(:note).permit(:text, :category_id, attachment_ids: [])
  end
end
