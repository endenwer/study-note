class Note < ActiveRecord::Base
  validates :text, presence: true
end
