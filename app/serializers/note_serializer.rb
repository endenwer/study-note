class NoteSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at
  belongs_to :category
  belongs_to :author, class: 'User'
  belongs_to :last_editor, class: 'user'
  has_many :attachments
end
