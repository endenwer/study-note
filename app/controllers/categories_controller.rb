class CategoriesController < ApplicationController
  before_action :notes, only: [:show]

  def show
    category = Category.find(params[:category_id])
    @presenter = {
      csrf_param: request_forgery_protection_token,
      csrf_token: form_authenticity_token,
      currentCategoryId: category.id,
      categories: Category.all,
      totalPages: (notes.total_count / NOTE_PER_PAGE.to_f).ceil,
      notes: ActiveModel::SerializableResource.new(notes).serializable_hash
    }
  end
end
