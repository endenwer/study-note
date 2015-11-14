class CategoriesController < ApplicationController
  before_action :notes, only: [:show]

  def show
    category = Category.find(params[:category_id])
    @presenter = {
      csrf_param: request_forgery_protection_token,
      csrf_token: form_authenticity_token,
      currentCategoryId: category.id,
      categories: Category.all,
      notes: notes
    }
  end
end
