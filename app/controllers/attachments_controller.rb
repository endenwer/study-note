class AttachmentsController < ApplicationController

  def create
    @attachment = Attachment.create(file: params[:file])
    if @attachment.persisted?
      render json: @attachment
    else
      render :nothing, status: 422
    end
  end

  def multiple_destroy
    @attachment = Attachment.find(params[:ids])
    @attachment.each do |a|
      a.destroy
    end
    render nothing: true
  end
end
