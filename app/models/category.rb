class Category < ActiveRecord::Base
  has_many :notes
  validates :name, presence: true
end
