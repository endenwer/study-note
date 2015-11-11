class CategoriesController < ApplicationController

  def show
    category = Category.find(params[:id])
    notes = category.notes
    @presenter = {
      currentCategory: category,
      categories: Category.all,
      notes: notes
    }
  end
end
