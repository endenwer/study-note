class AttachmentsController < ApplicationController

  def create
    attachment = Attachment.create(file: params[:file])
    if attachment.persisted?
      render json: {id: attachment.id}
    else
      render :nothing, status: 422
    end
  end
end
