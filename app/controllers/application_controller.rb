class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def notes
    if params[:q].blank?
      if params[:category_id].blank?
        @notes ||= Note.page(params[:page])
      else
        @notes ||= Note.where(category_id: params[:category_id]).page(params[:page])
      end
    else
      if params[:category_id].blank?
        @notes ||= Note.search params[:q],
                               page: params[:page],
                               per_page: NOTE_PER_PAGE
      else
        @notes ||= Note.search params[:q],
                               with: { category_id: params[:category_id] },
                               page: params[:page],
                               per_page: NOTE_PER_PAGE
      end
    end
    @notes
  end

end
