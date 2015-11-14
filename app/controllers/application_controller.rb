class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def notes
    if params[:q].blank?
      if params[:category_id].blank?
        @notes ||= ActiveModel::SerializableResource.new(Note.all).serializable_hash
      else
        @notes ||= ActiveModel::SerializableResource.new(Note.where(category_id: params[:category_id])).serializable_hash
      end
    else
      if params[:category_id].blank?
        @notes ||= ActiveModel::SerializableResource.new(Note.search params[:q]).serializable_hash
      else
        @notes ||= ActiveModel::SerializableResource.new(Note.search params[:q], with: { category_id: params[:category_id] }).serializable_hash
      end
    end
  end
end
