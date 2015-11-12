class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def notes
    if params[:q].blank?
      if params[:category_id].blank?
        @notes ||= Note.all
      else
        @notes ||= Note.where(category_id: params[:category_id])
      end
    else
      if params[:category_id].blank?
        @notes ||= Note.search params[:q]
      else
        @notes ||= Note.search params[:q], with: { category_id: params[:category_id] }
      end
    end
  end
end
