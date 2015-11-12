class CategoriesController < ApplicationController
  before_action :notes, only: [:show]

  def show
    category = Category.find(params[:category_id])
    @presenter = {
      currentCategoryId: category.id,
      categories: Category.all,
      notes: notes
    }
  end
end
