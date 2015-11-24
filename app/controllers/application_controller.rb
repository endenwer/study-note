class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def notes
    if params[:q].blank?
      if params[:category_id].blank?
        @notes ||= Note.where(group_id: current_user.group_id).page(params[:page])
      else
        @notes ||= Note.where(group_id: current_user.group_id,
                              category_id: params[:category_id]).page(params[:page])
      end
    else
      if params[:category_id].blank?
        @notes ||= Note.search params[:q],
                               with: { group_id: current_user.group_id },
                               page: params[:page],
                               per_page: NOTE_PER_PAGE
      else
        @notes ||= Note.search params[:q],
                               with: {
                                 category_id: params[:category_id],
                                 group_id: current_user.group_id },
                               page: params[:page],
                               per_page: NOTE_PER_PAGE
      end
    end
    @notes
  end

  def require_group
    if current_user.group_id == nil
      render "errors/without_group"
    end
  end
end
