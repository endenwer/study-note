class Note < ActiveRecord::Base
  belongs_to :category

  validates :text, presence: true

  default_scope { order('created_at DESC') }
end
